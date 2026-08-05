Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757A343A81A;
	Wed,  5 Aug 2026 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927836; cv=none; b=mucJldog9iaXyIeDHOoEPwca5BJFmODRcUxOQG2JD/ZUMaHZG6swjJ30pHf8QsLEVtGU6IU/9C71/4qMETpzREvlFFD86WxruGgykQ88S3T+Sb+ki1HxmKpDEp3aT+a5yH7mOOaN4pX7ThjBF+92Tfy/KXWBpl3/1Wwg7uP54Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927836; c=relaxed/simple;
	bh=vam/t1N6IT97N17AD+wC9on+SHw5SQJ31wu2TPXglJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS2k0uHULwfCol7lQ93fAqBalM3JZIQyehwS7EZXx5WEXuFhG2gdsXgmqDC1Cxadwgzf0fzFDDJaQXzo+WMWkfFeYjQr0uSBPd7Y4b1alDB/6yu/njz0TUns3j5NY7PrS/4UQ6lelOJudY9yI2Qb642nFthis8Is6C3cE1HtUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hB9aaRmH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hB9aaRmH"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81BBD20B7169;
	Wed,  5 Aug 2026 04:03:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81BBD20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927814;
	bh=gTX5HFZBUVieVTMJ1ys2qCD3TJ8fG6Q7VQSgAosmpCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB9aaRmH7LyqbXuaUC3l7VARW2yXvcqkixuA8otsc69FAKM7d40o+wyokxSFC6WYp
	 96+V/xvfNnhy0QahZnfd17jIHdmrzDWjecl7NMr8SiJ5aH+aOtIrv3GZreOsQo4l/N
	 SeeiIyABjOtNkEzahaZxgEmGtV7HtcfDJDXekA1g=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 13/42] Add a inter-plane communication mechanism through KVM. - model this to use a single page similar to SEV-SNP
Date: Wed,  5 Aug 2026 04:02:55 -0700
Message-ID: <20260805110324.25067-14-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---
 security/vbs/kvm_planes.c | 102 +++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/security/vbs/kvm_planes.c b/security/vbs/kvm_planes.c
index 3526f7c429c3..3eec3abb56ee 100644
--- a/security/vbs/kvm_planes.c
+++ b/security/vbs/kvm_planes.c
@@ -31,26 +31,30 @@
  */
 #define KVM_HC_VBS_VTL_CALL		15
 
-/* ── shared-memory request / response layout ──────────────────────────── */
+/* ── shared-memory calling area (modelled after the SVSM CAA) ─────── */
 
-struct vbs_kvm_request {
-	__u32	call_id;	/* enum vbs_call_id			*/
-	__u32	arg_size;	/* bytes of payload following this hdr	*/
-	__u8	payload[];	/* variable-length argument data		*/
+/*
+ * Single shared page used for both request and response data.
+ * The protocol is synchronous: plane-0 writes the request, issues a
+ * hypercall, blocks until QEMU returns, then reads the response from
+ * the same page.  No concurrent access is possible.
+ *
+ * Layout (within one 4 KiB page):
+ *   [ call_pending | call_id | status | arg_size | resp_size | buffer ]
+ */
+struct vbs_kvm_ca {
+	__u8	call_pending;	/* 1 while call is in flight		*/
+	__u8	rsvd[3];
+	__u32	call_id;	/* enum vbs_call_id (set by caller)	*/
+	__s32	status;		/* return code (set by responder)	*/
+	__u32	arg_size;	/* request payload size			*/
+	__u32	resp_size;	/* response payload size			*/
+	__u8	buffer[];	/* request data in, response data out	*/
 } __packed;
 
-struct vbs_kvm_response {
-	__s32	status;		/* 0 = success, negative errno		*/
-	__u32	resp_size;	/* bytes of payload following this hdr	*/
-	__u8	payload[];	/* variable-length response data		*/
-} __packed;
+#define VBS_CA_BUF_SIZE	(PAGE_SIZE - sizeof(struct vbs_kvm_ca))
 
-/*
- * A single page is used for each direction.  That gives ~4 KiB of
- * payload per call, which is enough for all current VBS operations.
- */
-static void *kvm_req_page;	/* request  (plane-0 writes, plane-1 reads)  */
-static void *kvm_resp_page;	/* response (plane-1 writes, plane-0 reads)  */
+static void *kvm_ca_page;	/* single calling-area page		*/
 
 /* ── low-level VTL call ───────────────────────────────────────────────── */
 
@@ -58,41 +62,44 @@ static int kvm_planes_vtl_call(enum vbs_call_id id,
 			       const void *arg, size_t arg_size,
 			       void *resp, size_t resp_size)
 {
-	struct vbs_kvm_request *req;
-	struct vbs_kvm_response *rsp;
+	struct vbs_kvm_ca *ca;
 	long hc_ret;
 
-	if (!kvm_req_page || !kvm_resp_page)
+	if (!kvm_ca_page)
 		return -ENOMEM;
 
-	if (arg_size > PAGE_SIZE - sizeof(*req))
+	if (arg_size > VBS_CA_BUF_SIZE)
 		return -E2BIG;
 
-	/* Build request in the shared page */
-	req = kvm_req_page;
-	req->call_id  = id;
-	req->arg_size = arg_size;
+	ca = kvm_ca_page;
+
+	/* Build request */
+	ca->call_id  = id;
+	ca->arg_size = arg_size;
+	ca->status   = 0;
+	ca->resp_size = 0;
 	if (arg_size && arg)
-		memcpy(req->payload, arg, arg_size);
+		memcpy(ca->buffer, arg, arg_size);
+	ca->call_pending = 1;
+
+	/* Issue hypercall: pass physical address of the calling area */
+	hc_ret = kvm_hypercall1(KVM_HC_VBS_VTL_CALL,
+				virt_to_phys(kvm_ca_page));
+	ca->call_pending = 0;
 
-	/* Issue hypercall: pass physical addresses of req & resp pages */
-	hc_ret = kvm_hypercall2(KVM_HC_VBS_VTL_CALL,
-				virt_to_phys(kvm_req_page),
-				virt_to_phys(kvm_resp_page));
 	if (hc_ret) {
 		pr_err_ratelimited("vbs-kvm: hypercall failed (%ld)\n", hc_ret);
 		return -EIO;
 	}
 
-	/* Read response */
-	rsp = kvm_resp_page;
-	if (rsp->status)
-		return rsp->status;
+	if (ca->status)
+		return ca->status;
 
-	if (resp && resp_size) {
-		size_t copy = min_t(size_t, resp_size, rsp->resp_size);
+	/* Read response from the same buffer */
+	if (resp && resp_size && ca->resp_size) {
+		size_t copy = min_t(size_t, resp_size, ca->resp_size);
 
-		memcpy(resp, rsp->payload, copy);
+		memcpy(resp, ca->buffer, copy);
 	}
 	return 0;
 }
@@ -192,34 +199,27 @@ static int kvm_planes_init(void)
 {
 	int ret;
 
-	kvm_req_page  = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	kvm_resp_page = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	if (!kvm_req_page || !kvm_resp_page) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	kvm_ca_page = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!kvm_ca_page)
+		return -ENOMEM;
 
 	ret = kvm_planes_vtl_call(VBS_CALL_INIT, NULL, 0, NULL, 0);
 	if (ret) {
 		pr_err("vbs-kvm: plane-1 INIT call failed (%d)\n", ret);
-		goto fail;
+		free_page((unsigned long)kvm_ca_page);
+		kvm_ca_page = NULL;
+		return ret;
 	}
 
 	pr_info("vbs-kvm: connected to plane-1 secure kernel\n");
 	return 0;
-fail:
-	free_page((unsigned long)kvm_req_page);
-	free_page((unsigned long)kvm_resp_page);
-	kvm_req_page = kvm_resp_page = NULL;
-	return ret;
 }
 
 static void kvm_planes_shutdown(void)
 {
 	kvm_planes_vtl_call(VBS_CALL_SHUTDOWN, NULL, 0, NULL, 0);
-	free_page((unsigned long)kvm_req_page);
-	free_page((unsigned long)kvm_resp_page);
-	kvm_req_page = kvm_resp_page = NULL;
+	free_page((unsigned long)kvm_ca_page);
+	kvm_ca_page = NULL;
 }
 
 /* ── ops table & registration ─────────────────────────────────────────── */
-- 
2.55.0

