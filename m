Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258522;
	b=cWXq/SjtvejeXTrQP2wvpGt8BoHFLc6SHQBVFrmSoDXsp+KsVRT89IxvkLI4KyvgPdqk
	 mhavHsan28SuluV6N5shOeQb7UnmUCjVJ7oIEXf6vEv2Wj5WBXlaI5Wjw8EJNYIKxpaP0
	 V6ZRt8F+iJjfuVcfPq1tCvooYfCiTMIo0ipA1VuANEPum6twVdUqnmvJ0xlq3IGa8jYcr
	 2xF94isimiqGDzhKhAt3WPtMAZVE0rx4D68vuMT3+Z+x7xvQR6JKxrJQSdiD6mdIuAjoX
	 5n2PKtvXiTLpbGS1hCpkIW0nO0A9bCROw1Q0mjahDbw6stxwk898rb+1lMP65sI8xDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wumk5mwNJr5KP1IwkSlRViD8R1WfLH7S/49T7W8Gkq4=;
	b=1NrU215Rofg/equlKg1nRv5x9SePz9uqEifA+459LrluDk0QP58YL/KNSVnBrOsatD+k
	 rSCFNtoccns9lVT98F90cf9WztcI9ZNofOhOCiGy2kRBiZSnYQxS/vnybeflb7+IMVbnJ
	 rz0KdmIcWzVGA/qcrf4HwvRVwVQsQDvrx3DicEnXJkAInF1wxDdaysURgDLPAZtbN5Rc6
	 vKvnTgx/slmV47xgwiQu7GqCRyps4i9Cwarxi/3LFiBuLnQTGxe7BRabP9JlAOaVH+fUu
	 WuxBSIrtlm3S7yVRkWuZYDq3jXYlr/OevTGYrAfbIi8gnjKc5/XGAkuAjsgvULg7X4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EXYrd52P;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1796606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1796606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EXYrd52P
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4adae323d5fso804627fac.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 13:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794258521; x=1794863321; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wumk5mwNJr5KP1IwkSlRViD8R1WfLH7S/49T7W8Gkq4=;
        b=EXYrd52PQ76SvhGvT5+fu2M3XpV+0iWbrSDWqXEjgx85hS98SACblNm/Pe+a8lctnj
         +FZrj0YgZn7DOQpjFVMz4RVPCW1oSrAfYxhqh9FRmi37OftO0gHAwE/2GXahW2NDCjP9
         +D/sKmBCusauxGMUu+MfiO/k5ovBKh/dAshnaqZTIc/3hoyN1Ymw/SfG8Bhcu/8jDAWE
         JL5+89fveAIrMToJJg5+AS0H+vIV7/SAfFl4m1720n6idX6I8FXc2VLoQ0j0dEe8vMlb
         0N5OKEXMKFcFZDJYM58SnRkeptuHkoC58x6QdNJrK1pTiDOShNO5Xqba9bpwE+rX+pKQ
         VNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258521; x=1794863321;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wumk5mwNJr5KP1IwkSlRViD8R1WfLH7S/49T7W8Gkq4=;
        b=xkIkDsyPA4uuHtoBVm+aX7nZtfL3wK9MOizVrBNneeYfT4jRE40URT7cVWJE5nmidM
         F9T8UIajFGjphYZqJydJVDyCb3ski9uzgaR3M74AUOUr9ZT+NWTix+1f5dVa35J1ujhc
         RcKD/TgrV5EMjpq4W9z5CE3cejSXvhodB1atlwymTOieyiGTJOf61BnpOUyGdfQlmShB
         JZFcUkxtcZquipt5lhbYYadbOXrpRbU7j+IMk7uNq8qKNtYaiLIHmu7s/DL4CBjeqcbA
         WcFjH9RJQxxoodqVcWlb1frHF0wJmQm9MqQkHvNLepxioIVS1G3pGEgQZJHvuAwIhY7e
         VlHg==
X-Gm-Message-State: APuU4Z++2MUHuP5Zl05smSK13XVnD9sJ6CIXSVtCKUD19ivfVWWKBFOo
	kdzYLmdigor/QMO4Q+21pAwEdHBihD8ntZ0CrXLafaJ6IaIxFMSX4kpKzrEMVSNmd0x0s46EIE5
	RGp0SyfU/xu7B1tG3XS82wlUTAH2YLc1AOlzubvgYHlNftleDxru0LB3Z2ied8uBxDFvn08IHCI
	wqCGuC7lUwhrVO3Lo6Emsh9DXLBPGEXXN3NTJhLsZGerw=
X-Received: from ilqu16.prod.google.com ([2002:a92:ccd0:0:b0:53c:3409:afff])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5094:b0:4d6:90f3:74b2 with SMTP id 5614622812f47-5683cb012b7mr675827b6e.50.1794258520143;
 Mon, 09 Nov 2026 13:08:40 -0800 (PST)
Date: Mon,  9 Nov 2026 21:08:32 +0000
In-Reply-To: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109210833.1250548-5-dmatlack@google.com>
Subject: [PATCH v3 4/5] KVM: selftests: Use VFIO selftests library to pick
 IOMMU mode in irq_test
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use the VFIO selftests library to pick the IOMMU mode in irq_test and
drop probe_iommu_type(). Pass NULL to iommu_init() when the user does
not specify a mode with -t, and skip the test if the requested mode is
not available, or if no mode is available at all.

probe_iommu_type() picks iommufd whenever /dev/iommu can be opened, even
if VFIO device cdevs are not available (CONFIG_VFIO_DEVICE_CDEV=n), in
which case the test fails rather than using the VFIO container. The VFIO
selftests library accounts for this when picking a mode, so there is no
need for irq_test to probe for a mode itself.

Note, this changes irq_test's default container mode from
vfio_type1_iommu to vfio_type1v2_iommu, which the VFIO selftests library
prefers. This only matters when iommufd is not available.

Opportunistically rename iommu_type to iommu_mode to match the
terminology used by the VFIO selftests library.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 791e576c334c..0d6ca1a052c4 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -148,22 +148,6 @@ static void kvm_set_empty_gsi_routing(struct kvm_vm *vm)
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing);
 }
 
-static const char *probe_iommu_type(void)
-{
-	int io_fd;
-
-	io_fd = open("/dev/iommu", O_RDONLY);
-	if (io_fd >= 0) {
-		close(io_fd);
-		return MODE_IOMMUFD;
-	}
-
-	io_fd = __open_path_or_exit("/dev/vfio/vfio", O_RDONLY,
-				    "Is VFIO (or IOMMUFD) loaded and enabled?");
-	close(io_fd);
-	return MODE_VFIO_TYPE1_IOMMU;
-}
-
 static void help(const char *name)
 {
 	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus] [-x]\n", name);
@@ -205,7 +189,7 @@ int main(int argc, char **argv)
 	int nr_irqs = 1000, nr_vcpus = 1;
 	bool set_empty_routing = false;
 	const char *device_bdf = NULL;
-	const char *iommu_type = NULL;
+	const char *iommu_mode = NULL;
 	int i, j, c, msix, eventfd;
 	bool migrate_vcpus = false;
 	cpu_set_t available_cpus;
@@ -235,7 +219,7 @@ int main(int argc, char **argv)
 			use_nmi = true;
 			break;
 		case 't':
-			iommu_type = optarg;
+			iommu_mode = optarg;
 			break;
 		case 'v':
 			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
@@ -266,9 +250,9 @@ int main(int argc, char **argv)
 	}
 
 	if (device_bdf) {
-		if (!iommu_type)
-			iommu_type = probe_iommu_type();
-		iommu = iommu_init(iommu_type);
+		__TEST_REQUIRE(iommu_mode_is_available(iommu_mode), "%s",
+			       iommu_mode_unavailable_msg(iommu_mode));
+		iommu = iommu_init(iommu_mode);
 		device = vfio_pci_device_init(device_bdf, iommu);
 		msix = vfio_setup_msi(device);
 		irq = vfio_msix_to_host_irq(device_bdf, msix);
-- 
2.56.0.506.g506a7eabc5-goog

