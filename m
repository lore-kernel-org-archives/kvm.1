Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DC3EA66
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600643; cv=none; b=G/3rNEziWLHr8dihlVz0GiqqO5HWjnWAjSyT3F0c07gyIs9lapGD9di1PmklPtpULGa31EAOYsQ1X1D7Hia0ydt6pEw1zGowaswAPZDwm6CAUHVJg7X9hulajnpI0x7Rg22/gz5Bgx9FC5kka0cSJwvWywylDVuXVaSnK9LOhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600643; c=relaxed/simple;
	bh=0FNgJ+94Gb14f4XGFbclkenmOC7Gf9VxBm6A3Fn7udU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tu69994a+zSZJXR8Qu3JD/EQzqBSBdJyJz4UKWhl995whuQ+RhZ0DI8UfgY/2orI99PHs3T9mztoLxvYsFcK7iqled0QCNJrgk/VZy8FwVg3xBuwIsvUeVR96lzazb6kw9N5Zu+u4xNjCY4+fLpkMvjxNTmnwmlnJCl15x5QMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC8vh6wB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC8vh6wB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bea7176c72so7708165ad.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780600642; x=1781205442; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pieX0NMTQ+eIXpcVHX498yvQ89YHesn3qbz1xO6zP/0=;
        b=lC8vh6wBz1WpM0Aein2zkVS1d/Tru0NZgz9IMzlNqRvo6DsKuFKw6cJ00Fwt760bcZ
         HYcOpbPw5ZTQyKSYIesyFVMcGgt+DcUcdFg19IpcamKMZSVzCaPfQIv7GG4Q9ng0BPc+
         zsh/yqnW/sHcNmPml4V1OTBVNieDMjoS5Q0xR8xOyG8ersyvgjEqKZ69CdjoACzbEXF6
         D34RKpu34iiAdks7n7PnWeeXL7mgDChMDo+r/LTCJsWQg0HHQHLrkT9ujfETRPpeFDdo
         O3xRyNIj1qVrQER2JwCOdDM4MiNC5PPT24pCEHfxmhi3BroYXM12dttv8i7VIxXzgiI7
         L4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600642; x=1781205442;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pieX0NMTQ+eIXpcVHX498yvQ89YHesn3qbz1xO6zP/0=;
        b=jiLXjoT3BO4CbFCxXSMo5V9YNwzowg8+888j3e0Aomt/rsgqP4gDHgcpig+Y17v99A
         a2wpudldIrrwmAxguyXI3Efx6Ff4UlxTM0Xxrd7kmPUa36EZ0EMMOSmFVkIWOUr9/5NQ
         ndzrFHK9cg+EZ7qtz3Il3TwHXmaX55prbJ3izI0Yj8xN0hYNlfb7uvx/wvxTxl1E3ZZp
         T2vvRmGhvFnbyM7tJuDfZL3Rms7l2sTNKF2vSNzVzJAGL7ZpX0V7KtAEOD5MACLtJ+Lw
         lXVKkb7qlqZqvdfsTSvNW6CVjoNkCV+LPsnz7n9Aoce5zYuYCEuiExnoi27+XxKFYqa7
         iwtA==
X-Gm-Message-State: AOJu0Yz4csjJvCEj/3gMZTxssIE1lUhIC/Z3qdWIIV/pkhCZnf5KHcd3
	DnI1E2JMFat+CsX8lFsT1Wsk5sVjRxUHNZLayNaNtpY/PUv3LOiSFpKfkdUAbQ==
X-Gm-Gg: Acq92OFvjx03WlH5uHLwb7ZdfmZagA4gWkRSzCrADyMzZf9xNyTLpRksLIS0Ynr2JQD
	1rX7VfhdxZZ9jZ38ZsbL4Jyjtf/Ao67x8kIOmdIVbC89iSiaganAU3/24uZORl0TfQFNT4JfGR9
	OpqQKCtaU/JhMPaD5Jb75lX/1yqV8zUoKx65UpyGRjL5+7O0JWD+khwSL7WaNlU+B25m7Dmn91Y
	Pl6PqHbmZoASm5Q+4w7z1IDSiB+KR5ytKsmgZbyXYgVuaPeIgrHg5+aghyeax121YgJNBDhJpDY
	KRa82++anU0C8y6HFW/nQSosOix567ap/6EWah6a+oZIfesklfSC+Nbm8H8lMYwxF4jGxUITe3e
	Sw6g0wWuoEh8ngtFjUV73exmFRGiLySJRpC8bu0JVi+AddQRD5JK+FZY9SyYRXpmtnOeJURlt1k
	ObB+IhtoFVlknKlzSwg/auoXunpFitmSHeZA3qjMABVOrt5FUJunPANfAgXcqilHF+
X-Received: by 2002:a17:902:7b87:b0:2bf:3636:222f with SMTP id d9443c01a7336-2c1639edf88mr63003655ad.7.1780600642005;
        Thu, 04 Jun 2026 12:17:22 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm67560165ad.2.2026.06.04.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:17:21 -0700 (PDT)
Date: Fri, 5 Jun 2026 04:17:17 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dwmw2@infradead.org, paul@xen.org, seanjc@google.com,
	pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Cc: kvm@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] KVM: x86/xen: Read long_mode only once in
 kvm_xen_set_evtchn_fast()
Message-ID: <aiHPPUk5DY7rH-zL@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

kvm_xen_set_evtchn_fast() assumes the port range check in max_evtchn_port()
and the bitmap layout selection observe the same long_mode, but each reads
kvm->arch.xen.long_mode separately. If the guest changes long_mode in
between, a port accepted by the 64-bit range check is handled with the
32-bit layout, and port_word_bit falls outside evtchn_pending_sel.

Read long_mode once on entry so the range check and both layout
computations use the same value. Since max_evtchn_port() reads long_mode
as well, compute the bound directly from the latched value.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/x86/kvm/xen.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..4d8337abf0fa 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1798,6 +1798,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	int port_word_bit;
 	bool kick_vcpu = false;
 	int vcpu_idx, idx, rc;
+	bool long_mode;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
 	if (vcpu_idx >= 0)
@@ -1809,7 +1810,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= max_evtchn_port(kvm))
+	long_mode = IS_ENABLED(CONFIG_64BIT) && READ_ONCE(kvm->arch.xen.long_mode);
+
+	if (xe->port >= (long_mode ? EVTCHN_2L_NR_CHANNELS :
+				     COMPAT_EVTCHN_2L_NR_CHANNELS))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1820,7 +1824,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
-	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+	if (long_mode) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
@@ -1861,7 +1865,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			goto out_rcu;
 		}
 
-		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+		if (long_mode) {
 			struct vcpu_info *vcpu_info = gpc->khva;
 			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
 				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-- 
2.43.0

