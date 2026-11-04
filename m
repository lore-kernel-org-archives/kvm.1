Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782633;
	b=sQze9K7pHgklIP78V/QtmxJTrC57/l2K3zKR/HB6cJuOFGqaywuoDEyb+fY5lIScbmMj
	 wr/s/gLgog5cBAAaRbpbF08dRKpQXSBu1GkB3YdY7xxidRYhOlynnha5gstAdxeXFEvy7
	 b+eMUccFg0hFZgNbXqtgbbh/p9bxaDsUxqld4WZMZFWpOl2YLnvwmGZNWrbay3h/WfHu3
	 SAKZiV8Gz3q6BEJSsTCPqCMI94TLtGm/NUe4xytw63aBzmG10vOep0agob8E+1BzL+uoX
	 fZQ1rw9K4nhRsKAvDjJiFSiFIqrGdZVYylIi8NgweSVL5txIXcD507Qu7iwO08et9Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782633;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gYu4safrZFRZxRz3PMkEnVIGx9pn9PlCpDYcYD2NAIg=;
	b=0ba8iMdRX+sU3Nycgnj73P6gz7Tt+kqmIXvjrbGvgguApMMCJJZ1IrJ18oeaE/m4rmNF
	 UGLeFzNxGXKgGMamGjcL5wMP6Uv6Th91kLnxmVd/EM8zAUEiLThpbI6fT+MQeVpZjOXzA
	 FBjRyk1Q6r8nZTL1ieI7ZaWPHunKNDtIfhL2cLD2HXR+AE4w4q9rQi0lBw/thUZy7ebBU
	 nnBJvP3CFi13z76Rq8stmuMe11LH66z95TG3UMFK/uger/TdPm0y9uCVsLA5434ehVhRo
	 QJI7Z+6Hv0z9flEDgQRGmPVBPoHl6tW8YsC7vH9bfUAMe6C4Ej5xSuwtYQUknYH8dSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="acu/8cdQ";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02C606A328;
	Wed,  4 Nov 2026 08:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC02C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=acu/8cdQ
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48iZvq018674;
	Wed, 4 Nov 2026 08:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gYu4sa
	frZFRZxRz3PMkEnVIGx9pn9PlCpDYcYD2NAIg=; b=acu/8cdQTElSAXHjKK3Kmi
	J8oR+9CUek+J0EBJ3HjStbc7GCefEs+glquVxZ4iGZaS5IFughXOq5edyiwXXaTY
	8ovS/FB46i7KjaT1HOAwce3OcY0F3r5IIhi7kKMCXSp9YWUNUy6gcG7y8kqWHOmZ
	lwR5YzZUK5jhcL8ZNYtXN4ldDz/CwIiMDvSyH+1sjQAVCFmUtrOBu3/Kwo+GT64o
	zWIy2Ub5kyhOoR+YMtpWDYIKBJpu9LwwhbAdqm4vbhGm1GH1f1ZcXXFAL+2QR98O
	RO7BPNrFiv0hZ/GmMGsDarg/juQRZp0yyo89IoVE3C45h257gZYG2PD6l4n3/TWg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhtqvn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:56:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48K3Un2676482;
	Wed, 4 Nov 2026 08:56:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf59qkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:56:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A48uu0w50921730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 08:56:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AF9C20040;
	Wed,  4 Nov 2026 08:56:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A970D2005A;
	Wed,  4 Nov 2026 08:56:54 +0000 (GMT)
Received: from [9.123.5.65] (unknown [9.123.5.65])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 08:56:54 +0000 (GMT)
Message-ID: <5bd7e8e9-3614-4006-a3d7-a51416ba5507@linux.ibm.com>
Date: Wed, 4 Nov 2026 14:26:53 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on
 kvm_arch_flush_shadow_all()
To: Sean Christopherson <seanjc@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
References: <20261030212112.2598640-1-seanjc@google.com>
 <20261030212112.2598640-4-seanjc@google.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20261030212112.2598640-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: D3HtbIrHYhFBVkH1Qk3wWusLux_I87WB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX+75I8chF9UB1
 cZ5RrnTSgZK+fW7yAb1FBW2kbxEDnxzKKm7KoFykscUKCm96SAL2vDM8XvDhAJsxzUTSFaYQ4uh
 RkruX2BfqtdJJfB503dMEyI5HDd/QU4=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aeaf35b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=1QS-1g0Vr6wPOSXTiQ0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX4eN8xeQe6Zf3
 ywbSZRXK9eMRl41agjGOMGmBmcZMIuf1c/GWQqDLHoTCm5GKkwFkjM2+aViHgMBVIGDMXyBt94u
 /5z4DAc3/evePjhod1tLEDxdchMzSy6epOlo+4dKGjO8g88sDgslDYx7lNKts5jO4ZlNdvuaQZP
 waBEWWwaFU8yswTLM4sEdY2DrBobeCJ/fjcIMNT1gjU4BmcRKYrcVlaY8OIg1z2aUfjydnA82AU
 nFIi/RCq4xt6rIPr62l0wWE+NgkO5HyU6aHYIMGwc1oQ1qqKUZQAem7Ugv8ZffPGihxRDTDqdDD
 89b8ZEX9HB4TDUc3uhY1e+uTIxt13vMvmsAj4JyF+c1gFG9CCCJADpFmxTXkvKvC0rlkodc47BF
 6c1b/b65727gRzZfde/SwMKxPPDqlfR8uO4R2RTaC+ZtDLPnQmSeZCZ68q5cDy+3mvLGBVv5kqC
 umz9a3kyq1vcMPzuUjg==
X-Proofpoint-GUID: Ay8acS_dMbzIo1IyKYWuxL5J_zhW18KV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040034

Hi Sean,

On 31/10/26 2:50 AM, Sean Christopherson wrote:
> Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
> owning userspace process is exiting, as KVM must ensure all associated
> memory is unmapped from the guest.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/powerpc/include/asm/kvm_host.h |  1 -
>   arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 708a32f89776..50a42f80e5f1 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
>   #define __KVM_HAVE_CREATE_DEVICE
>   
>   static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
> -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
>   static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>   static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>   
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..9e9d0865c2f6 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>   	kvmppc_core_commit_memory_region(kvm, old, new, change);
>   }
>   
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +	struct kvm_memory_slot *slot;
> +	struct kvm_memslots *slots;
> +	int bkt;
> +
> +	slots = kvm_memslots(kvm);
> +	kvm_for_each_memslot(slot, bkt, slots)
> +		kvmppc_core_flush_memslot(kvm, slot);

For Book3S HV/hash, I am not sure the existing flush_memslot helper can
be used on an active memslot like this.

The normal memslot invalidation path seems to deliberately establish
the opposite ordering.  kvm_invalidate_memslot() first installs an
INVALID slot and makes it active:

	invalid_slot->flags |= KVM_MEMSLOT_INVALID;
	kvm_replace_memslot(kvm, old, invalid_slot);
	kvm_swap_active_memslots(kvm, old->as_id);
and only then does kvm_arch_flush_shadow_memslot(kvm, old);.

The comment there explicitly states:
/*
  * From this point no new shadow pages pointing to a deleted,
  * or moved, memslot will be created.
  */

Similarly, kvmppc_core_flush_memslot_hv() in
arch/powerpc/kvm/book3s_64_mmu_hv.c relies on the memslot already being 
invalid when testing KVMPPC_RMAP_PRESENT without locking, as no new 
HPTEs can be created.

However, kvm_arch_flush_shadow_all() in arch/powerpc/kvm/powerpc.c now 
invokes the same helper while walking active memslots.

Is there any serialization in the mmu_notifier.release() path that 
provides the same guarantee against new HPTE creation?

Otherwise, couldn't an H_ENTER or fault path create a new HPTE while the 
rmap is being scanned, or after it has already been examined?

> +}
> +
>   void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>   				   struct kvm_memory_slot *slot)
>   {

Thanks,
Narayana Murty.
