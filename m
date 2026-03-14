Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3282E40B
	for <kvm@vger.kernel.org>; Sat, 14 Mar 2026 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773474471; cv=none; b=rBH41duse1zQfsYwf+FCz9Uhd/T6uJDMTYEPW9bhN+umlJI1AE5iCH95mpYDyvks85iL0GrzlOPFTAP9tgFqEyjTDqFTs0hZ6AxPzI0NhdDZehFMX2pGpm2Uehhrw6E9a42vSVtlng46oADIt32UszhN4r6OIFv9FdxAAElvZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773474471; c=relaxed/simple;
	bh=+LnyvEsOAMOuMraggW5GkBp3fbotg8e4CmYtqeF4Zk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEAp6ijlyzaLL30RRYH70UO8U1U5MAgoDDQ1vCckvl+3eCJhmbSKDLAkbXpJH9FjA3MMbB6y+V9tPOVSMhSEfYVKmxqND7EWUoGqciuOmIb/tyxdab7egLUC+3is5YntXyv+rDn9ZQMWb2BEYC+xrr3feISlumo6hAgpbb0eVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh8j/qp7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh8j/qp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773474469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nz3JZsYNT541pyf3vZdDq7MN88VWJEE5+FZGLQiaqlk=;
	b=Oh8j/qp7rX9YbLB5+Wom7Shv9nqGVvW27rFTssdKFYgucK5kLqy5EPiDNdeyoePHPMsH/C
	XbqrJu3Gzt3t0a2cp6y09zqFGuvg7lev/5RvahDu1ulG4rnWtRJFcSYL3/6/+SuCy7eHX/
	N55vbP4lxX82pEimpEEcvkMIB3E1WII=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-3YpBqvLHNB-VL5nad1kClg-1; Sat,
 14 Mar 2026 03:47:45 -0400
X-MC-Unique: 3YpBqvLHNB-VL5nad1kClg-1
X-Mimecast-MFC-AGG-ID: 3YpBqvLHNB-VL5nad1kClg_1773474464
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3968319560B5;
	Sat, 14 Mar 2026 07:47:44 +0000 (UTC)
Received: from [10.44.32.10] (unknown [10.44.32.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45FAF19560B7;
	Sat, 14 Mar 2026 07:47:42 +0000 (UTC)
Message-ID: <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
Date: Sat, 14 Mar 2026 08:47:40 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41>
 <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <abMS7MALNrmluvh5@acer-nitro-anv15-41>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 3/12/26 20:24, shaikh kamaluddin wrote:
>>> Alternatively, if you think this needs to be addressed in
>>> mmu_notifiers(eg. how non_block_start() is applied), I'm happy to
>>> redirect my efforts there-Please advise.
>>
>> Have you considered a "OOM entered" callback for MMU notifiers?  KVM's MMU
>> notifier can just remove itself for example, in fact there is code in
>> kvm_destroy_vm() to do that even if invalidations are unbalanced.
>>
>> Paolo
>>
> Thanks for the suggestion! That's a much cleaner approach than what I was considering.
> 
> If I understand correctly, the idea would be:
> 1. Add a new MMU notifier callback (e.g., .oom_entered or .release_on_oom)
> 2. Have KVM implement it to unregister the notifier when OOM reaper starts
> 3. Leverage the existing kvm_destroy_vm() logic that already handles unbalanced invalidations

Yes pretty much.  Essentially, move the existing logic to the new 
callback and invoke it from kvm_destroy_vm().

> This avoids the whole "convert locks to raw" problem and the complexity of deferring work.
> 
> I have questions on Testing part:
> ------------------------------------
> I tried to reproduce the bug scenario using the virtme-ng then running
> the stress-ng putting memory pressure on VM, but not able to reproduce
> the scenario.
> I tried this way ..
> vng -v -r ./arch/x86/boot/bzImage
> VM is up, then running the stress-ng as below
> stress-ng --vm 2 --vm-bytes 95% --timeout 20s & sleep 5 & dmesg | tail -30 | grep "sleeping function"
> OOM Killer is triggered, but exact bug not able to reproduce, Please
> suggest how to reproduce this bug, even we need to verify after code
> changes which you have suggested.

I don't know, sorry.  But with this new approach there will always be a 
call to the new callback from the OOM killer, so it's easier to test.

Thanks,

Paolo

