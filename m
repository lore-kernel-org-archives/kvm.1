Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0A23A564
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075938; cv=none; b=pCRPfluXS2ov2vyE5cCh4PDLXUebZxFhVMwjv0AaJSLm0V3+Z77B7caQpuZw4LhRfl2kYElDPEX2xIuqCtjs0p/LD/dIrofsRBcraVdfgBzYmwoHf11lqRaLFscuGNZHm9aOr0qUxtLjTsihAFsJFZgBO5MkD5JiDqrWCVSeMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075938; c=relaxed/simple;
	bh=7fISTYxxL4LMtv6VZ3q39YOYP86T33aDUHx4eFJqEn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBew4XxODe6QPKSmnDQfWf3hLJ713yYbO7eIcoj5uXLBF18/WvEkx4+ecCFCRaIzenggpj+dIrn/zTFYiCuKoGPyN4AxrHQo2Kw5zbHHDC90scu8ULjlTSJ9sTecbhdURW4wialtgQB/UXA8DbCzaIjksCKQW5ezP/b+BUqzDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cevDaGLM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="cevDaGLM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2a4e013a44so360425366b.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1792075933; x=1792680733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IensQ4I4ZLGLUvwGIgg/a4EL7NAcWNLKL27Qni5l6k4=;
        b=cevDaGLMi4TbxdE9HYMgQWuaeOhNHUnBi4lCmSIKH9ZjUaQ94viIMJdnjUzLi4OinU
         S/9ee0En0RL38DldaVWu7UmllkuymUAaiimB6A0JF4gqiDRIFvFm9g6EEGO1PkD6nM0W
         qELz6J56zAH8F3yHcIP6JAaiKemsbczmwSgf+NgKovmiJHxjA67FyHIjc67rNSrqSlsl
         uZj0nw7gIrScZOxYyvvPlNIJ4rhzo7t8QCdQjJi2xqqXl1Vy+Ot0jQSZhhydwIP+ypdR
         LhC5LU/63Fsw0m8UI6nVYUhxbcrir7lgO7D51duRp43jAFot1I/5ja1WmLIaduXgCdfj
         mOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075933; x=1792680733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IensQ4I4ZLGLUvwGIgg/a4EL7NAcWNLKL27Qni5l6k4=;
        b=IDPensP/HkcT1U2LmxDs6Ag44xpE61GUfUcJsbW1apdL5noVBIWTIMtUaAXVR6//Ij
         /bNoYPVTzEF/vCCzd8LTirbGrDX7VJvuA4/74xW7uj/or8Q9eq++aTSHU1KIimWt13nL
         eykSI2PH1JqITJynAF3Rmn+HrEQPWm8DoYHJ5G70/e2vWhest+nyI71ohtdH/TTFTQ0c
         9/yfRgo6T73TBtb2F+ZnEJQ82dBxAkSS7cjKqvIccQAXnPOmq2f2bwdO/q5RjvA1avqD
         yqzARfknVjY/u+Hxg5ftH35ErIFBdj7Cu25H1BZc+S1Ea6E4m/MYCIVX9gCuY6XsZt+O
         AnRg==
X-Forwarded-Encrypted: i=1; AKwUvBzK/VoptZIzW/rrTDhAtatj5zBdoHpxbSH1eu/byLR5SDWu+dJPh3LSKB3WyQ8Z3CjQ48s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaDr50lmlSyjFj7fzBB8ouh+8Zd/Vc66epU6ktL2XQtVNQcqCW
	u9oK4CFRHsbksT8MyCGRLdTD0JgYNcm4IolefDyptkry4WSUj1gvx1YumYL8CFID5V0=
X-Gm-Gg: AYBFou1GalmNeZr99JL9Q0ttzgGv0tmAj+O2+7s4nahYTV67G+un0FOKyyxfG1XpAYq
	1KYskOcjF9TV4ZuP7Ku1OW/1jJ07S4DyTB0JAHA4T9dQGwLQhfwFyQDCo92ssoNu8C1To4nPzzU
	Dkmm9DWT2T7lyyb2f+ipzMzIzd8PmuSsjAR2blrLtPdjLcLo1KGwFxwjiTJ8HN3i1aSvjQ+wgRf
	5a73BtzP6+B5/o9tGrpayvUL7azACNNU/DaAEyankR0KDlX2T085Drvq9hMbbTTS00TTtMkAV5X
	dGz6z3C2kfx2WFZmcsXZ0vFKkH/6rnN9DuGhgSXJjBUzcCyMX8slek4yJ9HN9R1Lu4X8WPPnVTP
	/z/BxAtCTyj+l8ODoQdGn4OAjd4U9ubizf29augFOG+F6zcx3d/HxmWqOZHD0mVcVeEDUb3SF/w
	fV9kxEDlDDMMQGxWqDMYq23OYCI1DylziG0massMZJpZm2LJwd69i9cpRYsnCSnDJCQT0bpPV/a
	vJYzTKelA==
X-Received: by 2002:a17:907:cf93:b0:c29:4634:5c99 with SMTP id a640c23a62f3a-c31a9a06099mr1662913166b.4.1792075932942;
        Thu, 15 Oct 2026 07:52:12 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6bea942sm135447266b.11.2026.10.15.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:52:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jgg@ziepe.ca,
	david.quigley@intel.com,
	lukas@wunner.de,
	ksinyuk@kernel.org,
	rodrigo.vivi@intel.com,
	cedric.xing@intel.com,
	sameo@meta.com,
	drdeeglaze@gmail.com,
	James.Bottomley@HansenPartnership.com,
	aik@amd.com,
	jpiotrowski@nvidia.com,
	qinkun@google.com,
	pgonda@google.com,
	jic23@kernel.org,
	alistair.francis@wdc.com,
	ankita@nvidia.com,
	suzuki.poulose@arm.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	peter.fang@intel.com
Subject: [PATCH RFC 18/20] tdx-guest: Expose the native attestation service API
Date: Thu, 15 Oct 2026 16:50:51 +0200
Message-ID: <20261015145053.3664509-19-jiri@resnulli.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015145053.3664509-1-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Share TDREPORT, Quote and measurement-register operations with one
in-kernel client while preserving the existing misc, TSM report and TSM
MR interfaces. Tie clients to service initialization and removal.

Assisted-by: Cursor: GPT-5.6 Sol
Assisted-by: Cursor: Claude Opus 5.5
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/virt/coco/tdx-guest.rst   |  18 ++
 MAINTAINERS                             |   3 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 258 +++++++++++++++++++++---
 include/linux/tdx-guest.h               |  75 +++++++
 4 files changed, 326 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/tdx-guest.h

diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
index 46e316db6bb4..759497b1434a 100644
--- a/Documentation/virt/coco/tdx-guest.rst
+++ b/Documentation/virt/coco/tdx-guest.rst
@@ -50,3 +50,21 @@ TDX reference material is collected here:
 https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
 
 The driver is based on TDX module specification v1.0 and TDX GHCI specification v1.0.
+
+Kernel clients
+==============
+
+``<linux/tdx-guest.h>`` exposes the same native service to one in-kernel
+client.  The client receives the misc device as its lifetime anchor and a
+complete ``struct tdx_guest_ops``.  The operations retrieve TDREPORT or Quote
+bytes, read MRTD/RTMR values, extend an RTMR, and return immutable construction
+fields.
+
+Registering a client attaches it immediately when the service is already
+available.  Otherwise attachment occurs when the TDX guest driver finishes
+initialization.  Driver removal calls the client's remove callback before
+freeing report or Quote buffers.  Client unregistration similarly drains the
+attachment before returning.
+
+The misc ioctl, TSM-report configfs interface, and TSM-MR sysfs attributes
+remain independent frontends over the same native serialization and buffers.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5972a643b3c3..a05d10976011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29669,6 +29669,9 @@ L:	linux-coco@lists.linux.dev
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
+F:	Documentation/virt/coco/tdx-guest.rst
+F:	drivers/virt/coco/tdx-guest/
+F:	include/linux/tdx-guest.h
 N:	tdx
 K:	\b(tdx)
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d0303e31e816..0d5317060246 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -19,6 +19,7 @@
 #include <linux/sockptr.h>
 #include <linux/tsm.h>
 #include <linux/tsm-mr.h>
+#include <linux/tdx-guest.h>
 
 #include <uapi/linux/tdx-guest.h>
 
@@ -27,10 +28,21 @@
 
 /* TDREPORT buffer */
 static u8 *tdx_report_buf;
+static struct tdx_guest_info tdx_guest_info;
+static struct miscdevice tdx_misc_dev;
+
+static_assert(TDX_REPORTDATA_LEN == TDX_GUEST_REPORTDATA_LEN);
+static_assert(TDX_REPORT_LEN == TDX_GUEST_REPORT_LEN);
 
 /* Lock to serialize TDG.MR.REPORT and TDG.MR.RTMR.EXTEND TDCALLs */
 static DEFINE_MUTEX(mr_lock);
 
+/* Serializes native client registration and service attachment. */
+static DEFINE_MUTEX(client_lock);
+static const struct tdx_guest_client *tdx_client;
+static void *tdx_client_priv;
+static bool tdx_service_ready;
+
 /* TDREPORT fields */
 enum {
 	TDREPORT_reportdata = 128,
@@ -49,24 +61,30 @@ enum {
 	TDREPORT_servtd_hash = TDREPORT_rtmr3 + SHA384_DIGEST_SIZE,
 };
 
-static int tdx_do_report(sockptr_t data, sockptr_t tdreport)
+static int __tdx_do_report(sockptr_t data, sockptr_t tdreport)
 {
-	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock) {
-		u8 *reportdata = tdx_report_buf + TDREPORT_reportdata;
-		int ret;
+	u8 *reportdata = tdx_report_buf + TDREPORT_reportdata;
+	int ret;
 
-		if (!sockptr_is_null(data) &&
-		    copy_from_sockptr(reportdata, data, TDX_REPORTDATA_LEN))
-			return -EFAULT;
+	lockdep_assert_held(&mr_lock);
+	if (!sockptr_is_null(data) &&
+	    copy_from_sockptr(reportdata, data, TDX_REPORTDATA_LEN))
+		return -EFAULT;
 
-		ret = tdx_mcall_get_report0(reportdata, tdx_report_buf);
-		if (WARN_ONCE(ret, "tdx_mcall_get_report0() failed: %d", ret))
-			return ret;
+	ret = tdx_mcall_get_report0(reportdata, tdx_report_buf);
+	if (WARN_ONCE(ret, "tdx_mcall_get_report0() failed: %d", ret))
+		return ret;
 
-		if (!sockptr_is_null(tdreport) &&
-		    copy_to_sockptr(tdreport, tdx_report_buf, TDX_REPORT_LEN))
-			return -EFAULT;
-	}
+	if (!sockptr_is_null(tdreport) &&
+	    copy_to_sockptr(tdreport, tdx_report_buf, TDX_REPORT_LEN))
+		return -EFAULT;
+	return 0;
+}
+
+static int tdx_do_report(sockptr_t data, sockptr_t tdreport)
+{
+	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock)
+		return __tdx_do_report(data, tdreport);
 	return 0;
 }
 
@@ -90,6 +108,76 @@ static int tdx_do_extend(u8 mr_ind, const u8 *data)
 	return 0;
 }
 
+static bool tdx_guest_device_valid(struct device *dev)
+{
+	return dev && dev == tdx_misc_dev.this_device;
+}
+
+static const struct tdx_guest_info *tdx_guest_info_get(struct device *dev)
+{
+	return tdx_guest_device_valid(dev) ? &tdx_guest_info : NULL;
+}
+
+static int tdx_guest_report_get(struct device *dev, const u8 *reportdata,
+				size_t length, void *out, size_t capacity,
+				size_t *out_length)
+{
+	int ret;
+
+	if (!tdx_guest_device_valid(dev))
+		return -ENODEV;
+	if (!reportdata || length != TDX_REPORTDATA_LEN || !out || !out_length)
+		return -EINVAL;
+	if (capacity < TDX_REPORT_LEN)
+		return -EMSGSIZE;
+	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock) {
+		ret = __tdx_do_report(KERNEL_SOCKPTR((void *)reportdata),
+				      KERNEL_SOCKPTR(NULL));
+		if (ret)
+			return ret;
+		memcpy(out, tdx_report_buf, TDX_REPORT_LEN);
+	}
+	*out_length = TDX_REPORT_LEN;
+	return 0;
+}
+
+static int tdx_guest_mr_read(struct device *dev, enum tdx_guest_mr mr,
+			     u8 value[SHA384_DIGEST_SIZE])
+{
+	static const size_t offsets[] = {
+		[TDX_GUEST_MR_MRTD] = TDREPORT_mrtd,
+		[TDX_GUEST_MR_RTMR0] = TDREPORT_rtmr0,
+		[TDX_GUEST_MR_RTMR1] = TDREPORT_rtmr1,
+		[TDX_GUEST_MR_RTMR2] = TDREPORT_rtmr2,
+		[TDX_GUEST_MR_RTMR3] = TDREPORT_rtmr3,
+	};
+	int ret;
+
+	if (!tdx_guest_device_valid(dev))
+		return -ENODEV;
+	if (mr >= ARRAY_SIZE(offsets) || !value)
+		return -EINVAL;
+	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock) {
+		ret = __tdx_do_report(KERNEL_SOCKPTR(NULL),
+				      KERNEL_SOCKPTR(NULL));
+		if (ret)
+			return ret;
+		memcpy(value, tdx_report_buf + offsets[mr],
+		       SHA384_DIGEST_SIZE);
+	}
+	return 0;
+}
+
+static int tdx_guest_rtmr_extend(struct device *dev, unsigned int rtmr,
+				 const u8 value[SHA384_DIGEST_SIZE])
+{
+	if (!tdx_guest_device_valid(dev))
+		return -ENODEV;
+	if (rtmr >= 4 || !value)
+		return -EINVAL;
+	return tdx_do_extend(rtmr, value);
+}
+
 #define TDX_MR_(r) .mr_value = (void *)TDREPORT_##r, TSM_MR_(r, SHA384)
 static struct tsm_measurement_register tdx_mrs[] = {
 	{ TDX_MR_(rtmr0) | TSM_MR_F_RTMR },
@@ -135,6 +223,12 @@ static const struct attribute_group *tdx_mr_init(void)
 	rc = tdx_mr_refresh(&tdx_measurements);
 	if (rc)
 		return ERR_PTR(rc);
+	memcpy(tdx_guest_info.mrconfigid,
+	       buf + TDREPORT_mrconfigid, SHA384_DIGEST_SIZE);
+	memcpy(tdx_guest_info.mrowner,
+	       buf + TDREPORT_mrowner, SHA384_DIGEST_SIZE);
+	memcpy(tdx_guest_info.mrownerconfig,
+	       buf + TDREPORT_mrownerconfig, SHA384_DIGEST_SIZE);
 
 	/*
 	 * @mr_value was initialized with the offset only, while the base
@@ -191,6 +285,8 @@ struct tdx_quote_buf {
 	u8 data[];
 };
 
+static_assert(TDX_QUOTE_MAX_LEN == TDX_GUEST_QUOTE_MAX_LEN);
+
 /* Quote data buffer */
 static void *quote_data;
 
@@ -265,15 +361,18 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 	return (i == timeout) ? -ETIMEDOUT : 0;
 }
 
-static int tdx_report_new_locked(struct tsm_report *report, void *data)
+static int __tdx_guest_quote_get(const u8 *reportdata, size_t length,
+				 void *out, size_t capacity,
+				 size_t *out_length)
 {
-	u8 *buf;
 	struct tdx_quote_buf *quote_buf = quote_data;
-	struct tsm_report_desc *desc = &report->desc;
 	u32 out_len;
 	int ret;
 	u64 err;
 
+	lockdep_assert_held(&quote_lock);
+	if (!reportdata || length != TDX_REPORTDATA_LEN || !out || !out_length)
+		return -EINVAL;
 	/*
 	 * If the previous request is timedout or interrupted, and the
 	 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
@@ -282,16 +381,13 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	if (quote_buf->status == GET_QUOTE_IN_FLIGHT)
 		return -EBUSY;
 
-	if (desc->inblob_len != TDX_REPORTDATA_LEN)
-		return -EINVAL;
-
 	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
 
 	/* Update Quote buffer header */
 	quote_buf->version = GET_QUOTE_CMD_VER;
 	quote_buf->in_len = TDX_REPORT_LEN;
 
-	ret = tdx_do_report(KERNEL_SOCKPTR(desc->inblob),
+	ret = tdx_do_report(KERNEL_SOCKPTR((void *)reportdata),
 			    KERNEL_SOCKPTR(quote_buf->data));
 	if (ret)
 		return ret;
@@ -317,13 +413,10 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 
 	if (out_len > TDX_QUOTE_MAX_LEN)
 		return -EFBIG;
-
-	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	report->outblob = buf;
-	report->outblob_len = out_len;
+	if (out_len > capacity)
+		return -EMSGSIZE;
+	memcpy(out, quote_buf->data, out_len);
+	*out_length = out_len;
 
 	/*
 	 * TODO: parse the PEM-formatted cert chain out of the quote buffer when
@@ -333,6 +426,39 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	return ret;
 }
 
+static int tdx_guest_quote_get(struct device *dev, const u8 *reportdata,
+			       size_t length, void *out, size_t capacity,
+			       size_t *out_length)
+{
+	if (!tdx_guest_device_valid(dev))
+		return -ENODEV;
+	scoped_cond_guard(mutex_intr, return -EINTR, &quote_lock)
+		return __tdx_guest_quote_get(reportdata, length, out,
+					     capacity, out_length);
+	return 0;
+}
+
+static int tdx_report_new_locked(struct tsm_report *report, void *data)
+{
+	struct tsm_report_desc *desc = &report->desc;
+	size_t length;
+	void *buf;
+	int ret;
+
+	buf = kvmalloc(TDX_QUOTE_MAX_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	ret = __tdx_guest_quote_get(desc->inblob, desc->inblob_len,
+				    buf, TDX_QUOTE_MAX_LEN, &length);
+	if (ret) {
+		kvfree(buf);
+		return ret;
+	}
+	report->outblob = buf;
+	report->outblob_len = length;
+	return 0;
+}
+
 static int tdx_report_new(struct tsm_report *report, void *data)
 {
 	scoped_cond_guard(mutex_intr, return -EINTR, &quote_lock)
@@ -402,6 +528,68 @@ static const struct tsm_report_ops tdx_tsm_ops = {
 	.report_bin_attr_visible = tdx_report_bin_attr_visible,
 };
 
+static const struct tdx_guest_ops tdx_guest_ops = {
+	.info_get = tdx_guest_info_get,
+	.report_get = tdx_guest_report_get,
+	.quote_get = tdx_guest_quote_get,
+	.mr_read = tdx_guest_mr_read,
+	.rtmr_extend = tdx_guest_rtmr_extend,
+};
+
+static bool tdx_client_attached;
+
+static int tdx_guest_client_attach(void)
+{
+	void *priv;
+
+	lockdep_assert_held(&client_lock);
+	if (!tdx_client || !tdx_service_ready)
+		return 0;
+	priv = tdx_client->add(tdx_misc_dev.this_device, &tdx_guest_ops);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+	tdx_client_priv = priv;
+	tdx_client_attached = true;
+	return 0;
+}
+
+static void tdx_guest_client_detach(void)
+{
+	lockdep_assert_held(&client_lock);
+	if (!tdx_client_attached)
+		return;
+	tdx_client->remove(tdx_client_priv);
+	tdx_client_priv = NULL;
+	tdx_client_attached = false;
+}
+
+int tdx_guest_client_register(const struct tdx_guest_client *client)
+{
+	int ret;
+
+	if (!client || !client->add || !client->remove)
+		return -EINVAL;
+	guard(mutex)(&client_lock);
+	if (tdx_client)
+		return -EBUSY;
+	tdx_client = client;
+	ret = tdx_guest_client_attach();
+	if (ret)
+		tdx_client = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(tdx_guest_client_register, "TDX_GUEST");
+
+void tdx_guest_client_unregister(const struct tdx_guest_client *client)
+{
+	guard(mutex)(&client_lock);
+	if (WARN_ON_ONCE(client != tdx_client))
+		return;
+	tdx_guest_client_detach();
+	tdx_client = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(tdx_guest_client_unregister, "TDX_GUEST");
+
 static int __init tdx_guest_init(void)
 {
 	int ret;
@@ -427,9 +615,19 @@ static int __init tdx_guest_init(void)
 	ret = tsm_report_register(&tdx_tsm_ops, NULL);
 	if (ret)
 		goto free_quote;
+	scoped_guard(mutex, &client_lock) {
+		tdx_service_ready = true;
+		ret = tdx_guest_client_attach();
+		if (ret)
+			tdx_service_ready = false;
+	}
+	if (ret)
+		goto unregister_tsm;
 
 	return 0;
 
+unregister_tsm:
+	tsm_report_unregister(&tdx_tsm_ops);
 free_quote:
 	free_quote_buf(quote_data);
 free_misc:
@@ -443,6 +641,10 @@ module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
+	scoped_guard(mutex, &client_lock) {
+		tdx_guest_client_detach();
+		tdx_service_ready = false;
+	}
 	tsm_report_unregister(&tdx_tsm_ops);
 	free_quote_buf(quote_data);
 	misc_deregister(&tdx_misc_dev);
diff --git a/include/linux/tdx-guest.h b/include/linux/tdx-guest.h
new file mode 100644
index 000000000000..65f367e4956a
--- /dev/null
+++ b/include/linux/tdx-guest.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_TDX_GUEST_H
+#define _LINUX_TDX_GUEST_H
+
+#include <crypto/sha2.h>
+#include <linux/types.h>
+
+struct device;
+
+#define TDX_GUEST_REPORTDATA_LEN 64
+#define TDX_GUEST_REPORT_LEN 1024
+#define TDX_GUEST_QUOTE_MAX_LEN ((128 * 1024) - 24)
+
+struct tdx_guest_info {
+	u8 mrconfigid[SHA384_DIGEST_SIZE];
+	u8 mrowner[SHA384_DIGEST_SIZE];
+	u8 mrownerconfig[SHA384_DIGEST_SIZE];
+};
+
+enum tdx_guest_mr {
+	TDX_GUEST_MR_MRTD,
+	TDX_GUEST_MR_RTMR0,
+	TDX_GUEST_MR_RTMR1,
+	TDX_GUEST_MR_RTMR2,
+	TDX_GUEST_MR_RTMR3,
+};
+
+/**
+ * struct tdx_guest_ops - Native TDX guest operations
+ * @info_get: Return immutable TD construction fields
+ * @report_get: Get a TDREPORT bound to report data
+ * @quote_get: Get a Quote bound to report data
+ * @mr_read: Read MRTD or an RTMR
+ * @rtmr_extend: Extend an RTMR
+ */
+struct tdx_guest_ops {
+	const struct tdx_guest_info *(*info_get)(struct device *dev);
+	int (*report_get)(struct device *dev, const u8 *reportdata,
+			  size_t length, void *out, size_t capacity,
+			  size_t *out_length);
+	int (*quote_get)(struct device *dev, const u8 *reportdata,
+			 size_t length, void *out, size_t capacity,
+			 size_t *out_length);
+	int (*mr_read)(struct device *dev, enum tdx_guest_mr mr,
+		       u8 value[SHA384_DIGEST_SIZE]);
+	int (*rtmr_extend)(struct device *dev, unsigned int rtmr,
+			   const u8 value[SHA384_DIGEST_SIZE]);
+};
+
+/**
+ * struct tdx_guest_client - Native TDX service consumer
+ * @add: Attach to the service and return client private data or an ERR_PTR
+ * @remove: Detach the client private data returned by @add
+ */
+struct tdx_guest_client {
+	void *(*add)(struct device *parent_dev,
+		     const struct tdx_guest_ops *ops);
+	void (*remove)(void *client_priv);
+};
+
+/**
+ * tdx_guest_client_register - Register one native TDX service consumer
+ * @client: Immutable add/remove callback pair
+ *
+ * Return: 0, or a negative errno.
+ */
+int tdx_guest_client_register(const struct tdx_guest_client *client);
+
+/**
+ * tdx_guest_client_unregister - Unregister a native TDX service consumer
+ * @client: Descriptor passed to tdx_guest_client_register()
+ */
+void tdx_guest_client_unregister(const struct tdx_guest_client *client);
+
+#endif /* _LINUX_TDX_GUEST_H */
-- 
2.56.0

