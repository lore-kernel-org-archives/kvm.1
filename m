Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3803330651
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188005; cv=none; b=JG+RPeeOT40kIDqA9j3FpViMDpwmaj3v1Djt6Oa8gdjk30/ji5+4nJjVPvSmg85NAlGlpK8XhipaH1ovFRI4qJO/dkaURNJFDxijbDP38A8NNgIcG6+sxE3Q53TLbjSrxvKldGfkHJYbASy4Y7Uneoc4IlXStikMV9jGOBToq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188005; c=relaxed/simple;
	bh=HbK1+JLVKgOJTFvYTojhO7JSe+mVALcF9merhE7NbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmHadEOHn4DYkHgj8huhPsJPNMB0jU+bcJNjoU9ZkgjbvFC5hddVkATKtkO+AReK6b3hhAiziUG27ysPgQjatUKvIDEsA0p1ereoTcTNND0yUaHsD2c2B690SjjBlKON1Yx1EIDaosRv6xDfHn2bAedUOCVGsST47p3qIZlwnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTr2uhPL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4XsqW/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTr2uhPL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4XsqW/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784188001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bl2gNkOAcxltrIfsVP1WCcvdBOInCr+iXCm5EqvvKhY=;
	b=UTr2uhPLyDS+T7ECAA3m8leB0DhrkTN7p89H0o4g5PNcJZZ7WTa6HC2rX51zrPCoRhYEei
	8Sfc7g7lL7UaK9v74ghcxywQsfyrfHN/ZxGuxwA+T7SAjUny1e+vAlhUulq9A0S3fUEztd
	Wx/DxL2JK9dY9K74wrLta8pjy1xkyTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-cfUP88fTNHOlRzI74KjpkQ-1; Thu, 16 Jul 2026 03:46:40 -0400
X-MC-Unique: cfUP88fTNHOlRzI74KjpkQ-1
X-Mimecast-MFC-AGG-ID: cfUP88fTNHOlRzI74KjpkQ_1784187999
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475de65009dso2360520f8f.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784187999; x=1784792799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bl2gNkOAcxltrIfsVP1WCcvdBOInCr+iXCm5EqvvKhY=;
        b=E4XsqW/mAGYBPdPIj1krXkDw68fVLtpkflszoDVZNymRS2PAAam6Bv1PNFWnaijC9/
         D9XdnRYxYP0f3S5YFnpPluTI5L3f1r+nTzEt+N5wBlJ0fLSHguVIcuAKZYn23KGe6IIu
         TIH/dLpbHztMgFaxDu0epy0q2m49CBgDcKgSxQCLX+jicQdL8PCNb1wS9REs1IOAuVqy
         Vo345WecjRoPAawxoPdPh/PyfbfG4b27ffKYS5e///OYBZrajfNDzmmUlMfMaXoFBF6e
         6bt762lanYP15ScDLLf7YbdUbVhBJIE8lADm0WIqRo+V5lEb0zDAk66/rS3KMztQ+h4Q
         lGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187999; x=1784792799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bl2gNkOAcxltrIfsVP1WCcvdBOInCr+iXCm5EqvvKhY=;
        b=pXdQURWwHnSgSP6uFnCuRRvk6MDatPi9ACxOGbzpgDCT22JtRn+Rrqav0X7EAOSoNm
         E9Za5yoZAot1f4fsuRFqLZsi5YlLlGB3y1SAF4bhdiSkXZhGw+fbkIGMBYLoVdor2j0n
         EtdFi7c8hGO+29mn3w9L8r2jhTsCJfnLbADw0y6nuW4tvDl4qx9OgDK/q//DaDUimkz2
         lilILUxZmH1K2Zvwl8dk3jTsw5JGyI0nvSFXWsLBvRYHItXbKqimzi9TYPR/Jg7R5Om9
         d2yU0QV/XK4PLdpjEjviz2GtZcP2mJi9kpen/AnYUqy55KGPfX+wvCxlJmNbuW/vTOWv
         RAhw==
X-Forwarded-Encrypted: i=1; AHgh+RoRp+MO1vTESx/7xpjUAXflCh5Z/KXmKxKyQhuRNpYOpAzWKuTQ814Rk96Cmzf0YDnPKDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywHJJ5ANqqdhW4qwttn7b+wtVII9IcjiDOSlWXwJM78NjI9rj
	+Ks85RJ+Np9VAqivmjm1m/LnfUOlxvSBZJiqjvyt41zqjkNwzxe7zcjwe6XdCw5n1uc678IjA45
	gyVxmbpnlkwPmCD1Lz1iBK00q0FfTdBr1JKZnZ0lKr89YCiSmdJPHbw==
X-Gm-Gg: AfdE7cnjz0ixHv2Vu019UEKgd3BCizcUbWEwG+ebI77CsHw4IEnr6QKgC+JTNKnUml4
	2cX3LSFij5UgSw/+CHW6UiW66XD7cx44fbWCS1kkm77uE1rxCgo+OGuBGU2D08UflkMau7/oi1L
	HZLR6jjI/+mnHlEaLHyrCNpxuCIJBu192j1v+uVAEJIEtw8L7+KDjoCNMMbl0Sbs94eebPW83tD
	OyfZgWT0Qy8dYedavuiv7BKrBwGf3PWZt2+XKLQ4gZcnaDAUVf1hpOFOBLnQNV0o15xOjBCZf49
	dI0pKJqLD9rwi2qXQPkxQen4TblaOnjYYr51Qjq0k+hIALkGLCDTL7IrzF1zgjYTyT4usAFcj+J
	Zl2CEF1QGzSrmATDZMANnLK04pz5f/9DOCGm1vcq/uHfkCnEbkRdraTR04KSWA+MSbwr5gOdlLi
	mRwbA=
X-Received: by 2002:a5d:5846:0:b0:475:94e1:29d5 with SMTP id ffacd0b85a97d-47f2dce942amr23649755f8f.20.1784187999228;
        Thu, 16 Jul 2026 00:46:39 -0700 (PDT)
X-Received: by 2002:a5d:5846:0:b0:475:94e1:29d5 with SMTP id ffacd0b85a97d-47f2dce942amr23649701f8f.20.1784187998681;
        Thu, 16 Jul 2026 00:46:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm22810165f8f.37.2026.07.16.00.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:46:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state
Date: Thu, 16 Jul 2026 09:46:36 +0200
Message-ID: <20260716074636.756689-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Put all vmcs12 pages if KVM synthesizes a nested VM-Exit due to invalid
guest while emulating VMLAUNCH or VMRESUME.  The invalid guest state path
doesn't use nested_vmx_vmexit() as that API is intended to be used if and
only if L2 is active, and the open coded equivalent neglects to put the
vmcs12 pages.  Failure to put the vmcs12 pages leaks any pinned pages
(and/or mappings) if L1 retries VMLAUNCH/VMRESUME.

Note, the !from_vmenter scenario doesn't suffer the same problem, as
vmx_get_nested_state_pages() only gets/pins/maps the vmcs12 pages if L2 is
active, i.e. if a "full" VM-Exit is guaranteed before KVM will retry
getting vmcs12 pages.

Fixes: 96c66e87deee ("KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page")
Fixes: 3278e0492554 ("KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table")
Fixes: fe1911aa443e ("KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bb0eb40b4448..220d42ebc82e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3761,6 +3761,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	if (!from_vmentry)
 		return NVMX_VMENTRY_VMEXIT;
 
+	nested_put_vmcs12_pages(vcpu);
+
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx))
-- 
2.54.0

