Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEF38945D
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713456; cv=none; b=mTxV5AaV6LBaRyDS6amE+htKwHF+afCdZXqCSQi5ST+FI9RdzmW4mraPlEA+jArz0t+FNMoPqH6m+9K7TzNJYlMd6qj4gW5fkJ4fZjszkNQ2+d7oN39AXfB+o2QVMzlZco32YtZA2VOuRZkiFGKDPufGLhChydYHJa4K66pJnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713456; c=relaxed/simple;
	bh=LIyR4z0SwigMgRcwFwZL7XDFKhQhg+3TuKsXg3f3Huc=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=TU+PkgYucy8LSz5xqccpBZSVHBqeXYHbFjXAsrMl9TqdMtNm+ID3d1uWMDPwUev+qfmelPhksdrkEp3j4bMBfCMRiVsclt4vlJCYtnGdw+SZdzdXNSxabJKNZJ7iW/hyqobDUNIg3NPO/0nI4LIBQc4afuznNLBIIpKdk9WW9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=x/fmR4Go; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="x/fmR4Go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782713443; bh=1yjUBAArT30ZzAYo5kLTy5I8GOq33p4jduAnrxwfH88=;
	h=Date:From:To:Cc:Subject;
	b=x/fmR4Go+aaVFuYDf4sdUNDmU0GuOvEyLCzMrWyatdl/o6wu8S7v7qWXNc52yHhXY
	 krd643J+JWEwKxNfJCgs8WfgCk2hR4LzbyNBhS2aNk7HUtq/2giqoxz5lNhifiJyHf
	 o3lDVVUrKXDFySYVFFMuYJljqAAPFXvkAuO94fNo=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 2A9210EB; Mon, 29 Jun 2026 14:10:41 +0800
X-QQ-mid: xmsmtpt1782713441t7ycz5ymd
Message-ID: <tencent_A78DC401911634111A3391650CB00FCD0409@qq.com>
X-QQ-XMAILINFO: NDiucA14li0CPJTx3Uah1XAwQ5rCmRanOF6aXxexlNbspOQDLJ6rMuq3Ow+u+S
	 Gv2lcgNiZDcY07TZ/h4tdHkyZkJctfvw8mdy5YZUNX+VRb1XQkGwBpYlREYHz/32qLosLwrFhu9e
	 VB4LvJimgKH94fMvgQTbqhCUJ9iHsSO6Ux+90aFGoKvSI3b+eDH93TTVQw5ZawX3/PznEudhm894
	 x8lWTpc9HkQUqHOYTsOljW+BR916P65WYhABUOhSbBKLBKEyFLkkqghr65J36pTfpflnu+CuXQnj
	 eE0sqJLfrmd+i9ItG999yUQt9yHWNYsM9S0lve6X7nPPaL0KfDdLtgmJcjbeLbMxVQJnqqa/wFIa
	 wNWg64AfZgAg+QrjHqc1cGxqzdycAmx4uGCMMKZgAXrzBdDEKQzO7MeFp3kjVT02Iiy2jU837ssC
	 I97kSEA8ySkeN+yl8wTAciADJSZeZ7o8KXjKrYuBH0gcj6luNjrJ2MCq+rT8SXwX+D42nALyEGrU
	 81zU7Kd6x1QZUY6H/NEaeMQUPUFu7RjrSum9EJZwm9nUf11itFQRaRTa3M7vHIFVQHqcD474FMw6
	 OGesWM5LEDbUAJ5iTW+W/O0wF9aMTG0OVViCv8FZvmXmvSSkEuuX8Gogkb/evrITh7zWUe+n2z3K
	 trUoCeFT10rJ4vmeddJ2+R5qxpK/OAlWFHNJ3kXN+UeNc/nWS36sT9HKBdzP33BOQqQkgHCUlobm
	 Sr5hmknP2vziM/43/tBMS0rhOzsc9hzK1hdESjYg1YrMExNoNUp5zuC/IGlVcnRCb/Yovsn8eN5R
	 UT9aMEW+ocLIHQk36edprXhhYGp/6sB6eV9xjEmW0D1Zhl5dBIWH0bGxOM1aYzHWdLqZNEO1Itzx
	 cKykLW86/g3moV9hmGNWmrEpvqoJE5dpyTOxSJRZ4SZz8PhBPTZOt3Q7tqHYPz8Twj5FU62kiIjs
	 gYD7vOuaDNZB1pNp8Aup40p4vzSx2xW1y9gQ8OuvaoACYoElYzUNy6tW57xB2eF7Pxy9T3nxmKFF
	 n3YsYA48nGRXM+4FWahcWLYBOqUqF24LSWyY82yNooKugJ1e7STeo+8j+bYRWQ7sBqan5kJpUHV/
	 JV2GnCd8aXuCHdTxU6PhcQSV9VdQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
Date: Mon, 29 Jun 2026 14:10:41 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] KVM: VMX: Use cached vcpu_vmx pointer in MSR and segment
 helpers
X-OQ-MSGID: <20260629061041.GA90586@zh-pc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From 3d30672f614d0472bf15ba9dd1efd085cddd5a93 Mon Sep 17 00:00:00 2001
From: Hao Zhang <zhanghao1@kylinos.cn>
Date: Mon, 29 Jun 2026 09:52:32 +0800

vmx_get_msr() and vmx_set_msr() already cache to_vmx(vcpu) in a local
'vmx' pointer, but a few cases still open-code to_vmx(vcpu).  Use the
cached pointer for consistency.

Likewise, cache to_vmx(vcpu) in vmx_get_segment_base() instead of
open-coding it in both the real-mode check and the VMCS read path.

No functional change intended.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/vmx/vmx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2325be57d3d7..b9ae10273f6f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2147,7 +2147,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !guest_has_spec_ctrl_msr(vcpu))
 			return 1;
 
-		msr_info->data = to_vmx(vcpu)->spec_ctrl;
+		msr_info->data = vmx->spec_ctrl;
 		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
@@ -2179,7 +2179,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_SGX_LC))
 			return 1;
-		msr_info->data = to_vmx(vcpu)->msr_ia32_sgxlepubkeyhash
+		msr_info->data = vmx->msr_ia32_sgxlepubkeyhash
 			[msr_info->index - MSR_IA32_SGXLEPUBKEYHASH0];
 		break;
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
@@ -2392,7 +2392,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		vmx_guest_debugctl_write(vcpu, data);
 
-		if (intel_pmu_lbr_is_enabled(vcpu) && !to_vmx(vcpu)->lbr_desc.event &&
+		if (intel_pmu_lbr_is_enabled(vcpu) && !vmx->lbr_desc.event &&
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
@@ -2471,7 +2471,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_MCG_EXT_CTL:
 		if ((!msr_info->host_initiated &&
-		     !(to_vmx(vcpu)->msr_ia32_feature_control &
+		     !(vmx->msr_ia32_feature_control &
 		       FEAT_CTL_LMCE_ENABLED)) ||
 		    (data & ~MCG_EXT_CTL_LMCE_EN))
 			return 1;
@@ -3666,13 +3666,14 @@ void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg)
 
 u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_segment s;
 
-	if (to_vmx(vcpu)->rmode.vm86_active) {
+	if (vmx->rmode.vm86_active) {
 		vmx_get_segment(vcpu, &s, seg);
 		return s.base;
 	}
-	return vmx_read_guest_seg_base(to_vmx(vcpu), seg);
+	return vmx_read_guest_seg_base(vmx, seg);
 }
 
 static int __vmx_get_cpl(struct kvm_vcpu *vcpu, bool no_cache)

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.15.0

