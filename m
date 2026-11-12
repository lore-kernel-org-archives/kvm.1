Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501550;
	b=kd3M6CwfzdGZDLPpDADwH2eEnkMaSd9gFyRcFJ0KVFC0ourrMxJ9ULbBfRVCquEQO5hl
	 YnGop/nsw28wru2MgBzembHjs2wE4lwvgpJEiefWtnfzj2nfwWupld4uaQLgYa7bxK/6H
	 WOzP+/a7qP+bWJPMCUBYm0EU1f4j1eXhkEldTZXgRlLtppMCLQFoRA39p1sHOqREz27PR
	 T7NUPHeVYrdHD0qDpBlS3PYOlXz/UEK8cyzDl8bMB+E7wggjA0C/r97l8K4BNXzUedsUG
	 EzW7kdHfTDRCzkEH096SrhRsGsc38aq6vFFZbass0cbF4OWzRfOSBiqalmClEa8qggw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dCI91LNMi1CWjSxyXSR9pkzi8gVuFB/yw882btF1cx4=;
	b=p8jtxxsGJqENMVk4Buim6VCSSsG3n2UcNiJjEmQfq+zm+v4kpM15btpN+qNMjEchWGHG
	 kGUyhC6CM+kNQR55Oz30dnz/4gLDEFDqwPbD32Xn4HvvMvmiexqFTTVK1IIhw5lDppZmG
	 gBWoSV913x+1kFFcIaugyjr3XlzQQ+NWPFvG9/NRtFllc9X5uvdcEd/RxtWORHfLDX0fh
	 UtOTNv1llXBJDHWXsklql1tiq3/bn7UqxFsMte2r+ylc2vHHxtAYWVmHU8bp5Uly1elI4
	 M0g1J9hwSHihwDeuwgXJIMAuiibzbh36wv7aEevhjBfkygGrHWzmNVADGANit15Gscw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gr+GUwGX;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D71606A33E
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 16:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D71606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gr+GUwGX
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so5555866a91.3
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 08:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794501549; x=1795106349; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCI91LNMi1CWjSxyXSR9pkzi8gVuFB/yw882btF1cx4=;
        b=gr+GUwGX001lkerYKRP5hlznLruNJRFEDi1nRmGrqi7qabGQE4Ky8Oz6X/iIhFae0K
         o1hTWgvqM5UO98+AvyYusCmiyPk88LDlJ2J5MQUUysV+J97HhY3PUZdZkmGNygEE3fcL
         n8uGff6+2KY1hXSrVfdlst3mREUNqKNgYrAx2YK5dWyvTmwZ97acIC5VbFxBQ+8dpPvb
         vQMsjEsJ8DehPq7o71YQ8VYYoUWy5tipgSdRDH6n22OCHB1lTTfW8OOlmfaMSvY1YNxv
         ITEthTNy9C4l5nwmYcu/AV8IILSGWSdDKApu2K2hJOBLEek4fXaIsaE+Fr/0xwO46Q/x
         7OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501549; x=1795106349;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCI91LNMi1CWjSxyXSR9pkzi8gVuFB/yw882btF1cx4=;
        b=fqwAEuioOaGzcuDgaZ+RDy4hufSedAsGdtaACDW+js7LxTJWe+qBaJJJhg2iHDYojH
         sYxo5twOGJBq4FmGZ3bbWaJNCaR4p0NmQ8Iuz9zJo3pG27u9JeblVIKBRCiOOud36HT7
         L3UxuycPJ5XWZD+C2PHt983kE4YRxLI/flW4TZTZeE+jB5cxc+y0MLJ53ZNsikD1BOOD
         LvAStCrGpACYLzKOchcGVhQzmxB+soQVxqkf2eF7FVKAHbx44BId2QekyLQwPf5SCgna
         0yZlYEjhhHskAaxBFFTQIEy+94VBHqcU3HqP3FFvk8PIoYmKkx4IdAT7fp5rw7h5N6HK
         sFEw==
X-Forwarded-Encrypted: i=1; AL+hErGPFE6JtZJcvM/xgjDd078XtJPw5xgp0MFGjOIPFjcKXJ4WtYVbWCszs53+PQNu3KYvGuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LxymvNMhoK/M/kIBDzTyJbsyKg+C8T/dTYYA723++pcy1XzLH
	Ovorj+wx7EFVcUqHCpBLvn1VoIhRBNhCi3x8GyWFtpGKyB2sFRz2tDhKa6PjCgxWI73sBO9YVjw
	BHyOqJg==
X-Received: from pglf35.prod.google.com ([2002:a63:1023:0:b0:cd6:23e7:ad7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cc:b0:3b0:9162:948e
 with SMTP id 98e67ed59e1d1-3b182eda812mr5907218a91.27.1794501549149; Thu, 12
 Nov 2026 08:39:09 -0800 (PST)
Date: Thu, 12 Nov 2026 08:39:07 -0800
In-Reply-To: <20261112132512.68348-1-likexu@tencent.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112132512.68348-1-likexu@tencent.com>
Message-ID: <avXrdHhup76EoDQ8@google.com>
Subject: Re: [PATCH] KVM: x86: Don't patch L2's hypercall if L1 intercepts #UD
From: Sean Christopherson <seanjc@google.com>
To: Like Xu <like.xu.linux@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oupton@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 12, 2026, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The fix_hypercall_test selftest fails when run in an L1 VM on an AMD host:
> 
>   ret == (u64)-EFAULT
> 
> On SVM, L0 always intercepts #UD in vmcb01, so nested_svm_exit_special()
> claims every #UD from L2 for L0, before L1's intercepts are consulted.
> L0 then emulates L2's VMCALL and, based on the quirk that L0 userspace
> configured for L1, patches it to VMMCALL. This ignores L1's decision to
> disable KVM_X86_QUIRK_FIX_HYPERCALL_INSN for L2.
> 
> Synthesize #UD instead if the vCPU is in L2 and L1 intercepts #UD, so
> the nested exception machinery reflects it to L1.  Keep patching L2's
> instruction when L1 doesn't intercept #UD, as existing userspace relies
> on it, e.g. nested SVM selftests execute VMCALL in L2 and expect L1 to
> see SVM_EXIT_VMMCALL.
> 
> Fixes: f1a9761fbb00 ("KVM: x86: Allow userspace to opt out of hypercall patching")
> Signed-off-by: Like Xu <likexu@tencent.com>

I think I'd rather fix this by skipping the selftest, e.g.

diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index f11fcc520f24..bb2fdd622538 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -135,6 +135,7 @@ KVM_ONE_VCPU_TEST(fix_hypercall, disable_quirk, guest_main)
 
 int main(int argc, char *argv[])
 {
+	TEST_REQUIRE(!this_cpu_has(X86_FEATURE_HYPERVISOR));
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
 
 	return test_harness_run(argc, argv);

I doubt there's a deployment that would actually break if L0 stopped patching L2,
but the right solution here really is to disable the quirk in L0.  Any risk of
breaking existing setups, however small, just isn't worth it IMO.
