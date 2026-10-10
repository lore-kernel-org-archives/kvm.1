Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AE358363
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651663; cv=none; b=b1iFO+X0/xZOUfMttHNNmCtpSKr2fRk8HXreeagIuxOaIyG5qMjdycadL43U8/D1sOIjM/Hr53ya6ZvqsR8Lg0YCoukTodb+0HyhU0WCQs8fbdJKXsL12N+fO7Eg1bc8MXLbaqDzkyNdXWtr75jU4j8k0Suy1QYFFrrIA5fdLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651663; c=relaxed/simple;
	bh=svmSHL/ynjXEg6ajN2kLOnbWJgU4XqKuOp5k7Pc0r3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8h2cS+pcuNhkw9KwOJBT53sr3ng6xTQ5EgtlRcQwggtlEXE3ptdQHspBvKdwbg9GgznQY21RI8JC1atONKOWy/wJb8pWdgUBmFB0d/kXhe6el7+llYnWuGSNuTFKVvJw4tFNMrI6z8/fvJkWP2cC9WmoK2PcVGHIV1OhD1W/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+vq3Cj+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJzmeCGv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+vq3Cj+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJzmeCGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791651661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+m7pBfG9zN2hTnmKrun1UbP204UC9X1YckW1gKfjXo=;
	b=I+vq3Cj+yNX/UsSdp3001LrcgcI22yY9hvwYBFrygafgchIZ2jOg4+9weBRyACf2E8KWNf
	EaeLROCtFnxRt7kNR0oHogOP4SK740rivqOafzzGQM6eFZYd8AQIQNoWy1gx3oHeXYzs3B
	BsrZ5KQQrDeGge6kYXetJzbSf3cj5/E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-X1xmsEBzPseweLdoq-AUAQ-1; Sat, 10 Oct 2026 17:00:59 +0000
X-MC-Unique: X1xmsEBzPseweLdoq-AUAQ-1
X-Mimecast-MFC-AGG-ID: X1xmsEBzPseweLdoq-AUAQ_1791651659
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917870a9be3so57881926d6.0
        for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791651659; x=1792256459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I+m7pBfG9zN2hTnmKrun1UbP204UC9X1YckW1gKfjXo=;
        b=eJzmeCGvtg3fSjKoO3sLFwoTCD+BwKUBI/CqPU+sxDmxUpl95nUM0jsD8gue73S7GA
         FlrS6YL52FrQqoxvh0q457uvPXU/uH45yMkE9Am602Z5pSk3tTVSR/gjM0la2gYcSbOm
         CPmDTx8XS+HKy0k7VZkgX1Ahs4KgibXyhF7tYPsNSYASCtTn373DCMElY33mD67fUhjZ
         8upl8D2da+LNUJN8LVIbwGJ5q2IijAIzunM6mOq9Nw95mHNzZlE8asJ2rAwZ1FUG4Xh6
         NXEMMe0sCNg5A65gjh6rK5Cm66lSk4QUeg9c25+lRuZ2LcZZLkMQjyLUMDHKyqKwb7TD
         IA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791651659; x=1792256459;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I+m7pBfG9zN2hTnmKrun1UbP204UC9X1YckW1gKfjXo=;
        b=zF+PIOzjs4kd8CtOLmnCj5BI7/5uHrXePj9nZzUU57w2VDePOJHH07JIL6ZahB/tD4
         3Yd0ItUD0uagSij0QkSXNqFTjWVs/qPcgBFoVPFuJ2vVhDTzwLNK4d8zVX7oKv0w5qeI
         E/4qZcOmwwgzs3JJbDxL7G8k7ANsh09+FIHJLC5ABBvucrowPXTbauu/OXH9dB2iiXBY
         r2ZtVjywoVdI8VlITWZoXZtoIN1ma6OgN5YOalW/QAGZrIrw/4wJID99eiKzkqSgoBwJ
         SfExfcjdxBqyvXpZBqCN7xbIAZpj/PDfvoxr5F5qNG1Cxaqde3AjS1BapFXTVQTh7FiR
         9C4A==
X-Gm-Message-State: AFq9FYLb/wKVq+YgevN8mdsPRNSp+TakTJqsG5UWwKuj1BwlyM+s/hI6
	Il6ReSIABWFsMBOzL0VNxp7N++RE/LzxYT6aDEdRlllpaTCE/BECZZQDybVTxiLJ72HzLAcAvIS
	FGg6pm/BQb6d2S/bk3CseeMTR8WXNP4AQyEy9kxOqpa6sEN6Vzp7+Kzh50o+8h8uK7p9Ssds8oq
	OenJ/srZpF6UoinVLc/I57xcDD6suO1lQSt9YPgw==
X-Gm-Gg: AYBFou3GA/J1apVAvlEnc/VrrA8WuT33DUbLGfy9BDeWh6ph5MixdfYuQpID9LJCuV4
	rVjNcAGhOiv0c6uNnwis+LAnToY2agym2zM451cYXtc1JmQDaJ9TgQ1ozMEhOuoG9TbpSWvNg/Q
	/qEbcIEw22mO7XvVOkzdAFFoKiatlpBMsA26i+aJhAJwNICOTnW/R8pOM53e+zthjDpGtp78r85
	XfGIG+6WhGOg2GcCz62ASZ0fV8UMpOrzYDc9y5V9zdZIlaDK4UHUvHxqBWR6GaQSg1seUUf/GOV
	IqY29xWKL57HEVkID6qZKdHmMRsc4p2nk6n/edqrQgzTcx9pRxaYs2jc5oZNUQLA+GkfF+218bV
	7tZmMf9XO/nq/OG9U9XwPdOHKRIdeR2QoN05f1s0avL/8PWBiQTTAU81qmtoWoAlHWSMDqntP63
	1PdXprg3f1
X-Received: by 2002:a05:622a:2285:b0:535:1463:ec25 with SMTP id d75a77b69052e-535a61e2915mr68879421cf.25.1791651658481;
        Sat, 10 Oct 2026 10:00:58 -0700 (PDT)
X-Received: by 2002:a05:622a:2285:b0:535:1463:ec25 with SMTP id d75a77b69052e-535a61e2915mr68878661cf.25.1791651657794;
        Sat, 10 Oct 2026 10:00:57 -0700 (PDT)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (pool-173-33-204-162.cpe.net.cable.rogers.com. [173.33.204.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b46b471sm44058171cf.1.2026.10.10.10.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 10:00:57 -0700 (PDT)
Message-ID: <898b1b8ba85284a4f4094ce0453ea59d094c1c3b.camel@redhat.com>
Subject: Re: [PATCH 2/2] KVM: nVMX: avoid losing the posted notification
 interrupt when exiting L2
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 13:00:55 -0400
In-Reply-To: <20261009205036.672523-3-mlevitsk@redhat.com>
References: <20261009205036.672523-1-mlevitsk@redhat.com>
	 <20261009205036.672523-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 16:50 -0400, Maxim Levitsky wrote:
> While delivering a nested posted interrupt notification
> (see vmx_deliver_nested_posted_interrupt), KVM assumes that,
> as long as the target vCPU is in the guest mode, KVM can send the
> special POSTED_INTR_NESTED_VECTOR, which will either trigger APICv ucode
> to inject all interrupts into L2 or cause a VM exit, after which
> vmx_complete_nested_posted_interrupt is supposed to finish the job.
>=20
> However, a third case is possible: if the target vCPU is about to exit
> to L1, the posted notification interrupt must be instead injected
> to L1' APIC, but KVM doesn't do this.
>=20
> Detect this case in the nested VM exit path and act accordingly.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
> =C2=A0arch/x86/kvm/vmx/nested.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 2142e25c9b6c..4d8bb7f7fcd4 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2445,7 +2445,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *v=
mx, struct loaded_vmcs *vmcs0
> =C2=A0			 ~PIN_BASED_VMX_PREEMPTION_TIMER);
> =C2=A0
> =C2=A0	/* Posted interrupts setting is only taken from vmcs12.=C2=A0 */
> -	vmx->nested.pi_pending =3D false;
> +	WARN_ON_ONCE(vmx->nested.pi_pending);
> =C2=A0	if (nested_cpu_has_posted_intr(vmcs12)) {
> =C2=A0		vmx->nested.posted_intr_nv =3D vmcs12->posted_intr_nv;
> =C2=A0	} else {
> @@ -5162,6 +5162,14 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u3=
2 vm_exit_reason,
> =C2=A0	kvm_clear_exception_queue(vcpu);
> =C2=A0	kvm_clear_interrupt_queue(vcpu);
> =C2=A0
> +	if (lapic_in_kernel(vcpu) && vmx->nested.pi_pending) {
> +		vmx->nested.pi_pending =3D 0;
> +		if (!WARN_ON_ONCE(vmx->nested.posted_intr_nv =3D=3D -1)) {
> +			kvm_lapic_set_irr(vmx->nested.posted_intr_nv, vcpu->arch.apic);
> +			kvm_make_request(KVM_REQ_EVENT, vcpu);
> +		}
> +	}
> +

Hi!

After giving this a bit more of thought, I see that this will introduce spu=
rious interrupts to L1,=C2=A0
if the posted interrupt was actually served by APICv.

ON can't be trusted, so I only can add scan of PIR here to reduce chances o=
f this happening, but I am not sure
that this can be completely avoided.=C2=A0

I think that a spurious interrupt is better though that no interrupt becaus=
e the guest can depend on it, and might
not even enter the L2, until it receives this posted interrupt.

What do you think?

Best regards,
	Maxim Levitsky



> =C2=A0	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> =C2=A0
> =C2=A0	kvm_nested_vmexit_handle_ibrs(vcpu);

