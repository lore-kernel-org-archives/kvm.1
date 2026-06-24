Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F62C21C4
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294645; cv=none; b=Xxmjb0Iun2GczDflSQCaTj83Fr2HczKDXd8OCqli/xeWp9Oyz8AjN1kro3gfmWflEs6/S82NXsfM+LmlvLP3Zp4cRG04D7MrmkPSLW+/g0T6CmQzQwa53snFiTnKT+HQqPx59SGSDj0KFubgTGiJC9wuLd98VHNv/fPtIswIDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294645; c=relaxed/simple;
	bh=DMy/OpqrY0+DdDz/HufWMcPpKO+HBSJUXvt4GRBPuPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXjkrrng4AoCr0OJkQRECNXFsuWFAonMc9m7uZEMXHuOovfdWGnnWZY3H9vhB55Yg/lgdTG/wPzYKNFmRZEvX9ApBQ/50FYVmZ+joOXOMOcjIwN+l3L88iDl43gLdAUQtOWu5SRvEJnBGvcWGo4tPzkGwYa6l2DLB9z3D/C8zDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRHapgpS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRHapgpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782294642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nLE5v5ozqvD4vyn18+GOZLA4rvhcv5Jr1VYMrTXk7jU=;
	b=RRHapgpS8EHAryRhowcEdsPpeQwOl+sjVA19gAbKLh9OXM5HmPmoDpH7CA7hd1K1xyOdMJ
	nyUhDBAoWgvKlt83Bm/HnhxyNxFDD+NbOFCj2d7acO9skgCvCbhtpMAHfCwM/Q7DCfHM7T
	BVqUPWgG2+7OMsZEyyYI8JTTh61mtkU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-3rnTxV6xN0SSO51Ds0hjLw-1; Wed,
 24 Jun 2026 05:50:40 -0400
X-MC-Unique: 3rnTxV6xN0SSO51Ds0hjLw-1
X-Mimecast-MFC-AGG-ID: 3rnTxV6xN0SSO51Ds0hjLw_1782294639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31D418005BD;
	Wed, 24 Jun 2026 09:50:39 +0000 (UTC)
Received: from [10.44.50.109] (unknown [10.44.50.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDAD51955F6F;
	Wed, 24 Jun 2026 09:50:38 +0000 (UTC)
Message-ID: <3948934a-eb84-418f-b29e-c1176b47370d@redhat.com>
Date: Wed, 24 Jun 2026 11:50:36 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618185515.2021642-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260618185515.2021642-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 6/18/26 20:55, Sean Christopherson wrote:
> If KVM handles an I/O APIC EOI exit request with a bad vector, clamp the
> vector to 255 and hope for the best instead of bugging the host.  In all
> likelihood, a missed EOI is survivable for the guest, and it's most
> definitely not remotely fatal to the host, i.e. potentially panicking the
> host is completely unjustified.  Arbitrarily use 255 for the dummy vector,
> the goal is purely to ensure the vector is covered by the bitmap.
> 
> Opportunistically ensure the EOI vector isn't negative, as it's a signed
> integer, i.e. the "greater than 255" check won't guard against setting the
> vector to a negative value (KVM uses -1 to say "no IRQ" in many flows).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d9d51803b7b2..fda09e03b960 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11212,7 +11212,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   		if (kvm_check_request(KVM_REQ_NMI, vcpu))
>   			process_nmi(vcpu);
>   		if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
> -			BUG_ON(vcpu->arch.pending_ioapic_eoi > 255);
> +			if (WARN_ON_ONCE(vcpu->arch.pending_ioapic_eoi < 0 ||
> +					 vcpu->arch.pending_ioapic_eoi > 255))
> +				vcpu->arch.pending_ioapic_eoi = 255;
> +

Yay, it's my turn to say "why?!?" I'm not going to go full Linus on
it :) but I've been waiting for the moment for years!

If this happens we have a much bigger problem: the vector is set in
kvm_ioapic_send_eoi() and ultimately comes from apic_find_highest_isr().
It is simply not going to happen.

Unlike pending_external_vector or highest_stale_pending_ioapic_eoi, this
cannot even be -1...255 so make it u8 and call it a day?

Something like this:

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eee473717c0e..9c444dfa7342 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1082,7 +1082,7 @@ struct kvm_vcpu_arch {
  		bool pv_unhalted;
  	} pv;
  
-	int pending_ioapic_eoi;
+	u8 pending_ioapic_eoi;
  	int pending_external_vector;
  	int highest_stale_pending_ioapic_eoi;
  
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9d2df8623f6d..fca9be6e536d 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1541,7 +1541,7 @@ static bool kvm_ioapic_handles_vector(struct kvm_lapic *apic, int vector)
  	return test_bit(vector, apic->vcpu->arch.ioapic_handled_vectors);
  }
  
-static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
+static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, u8 vector)
  {
  	int __maybe_unused trigger_mode;
  
@@ -1611,7 +1611,7 @@ static int apic_set_eoi(struct kvm_lapic *apic)
   * this interface assumes a trap-like exit, which has already finished
   * desired side effect including vISR and vPPR update.
   */
-void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
+void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, u8 vector)
  {
  	struct kvm_lapic *apic = vcpu->arch.apic;
  
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a1a5edb39a7e..57333d7bb32c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5866,7 +5866,7 @@ static int handle_apic_access(struct kvm_vcpu *vcpu)
  static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
  {
  	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	int vector = exit_qualification & 0xff;
+	u8 vector = exit_qualification & 0xff;
  
  	/* EOI-induced VM exit is trap-like and thus no need to adjust IP */
  	kvm_apic_set_eoi_accelerated(vcpu, vector);

and then obviously the BUG_ON goes away.

Paolo

