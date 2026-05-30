Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB303A3E76
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161246; cv=none; b=VK3VUAuolCHO6Z16w7PaMip1KZWChEYujzjHaA97hEjnyZxD2admxZcWN95oD2cnzxcJDIvPMOiaV01k4e18cz/JNwH7YcQ6RKCzuTeAc6uX1O70dPi5OIktMWm4ZZIxsLmJ4sILmRada/OKV9qSxTDjH4yMyzBpXt/9Awa2k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161246; c=relaxed/simple;
	bh=QZ2c05B3I9q/CT3AmZiNQN8SMcAJhe9o7iJRKl0st5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyjCJaqJN5RP7l05R3ThlJ/NTAcwwa2/j7ZdAiI8ot0IZn/bboxIQjGYdTQsVzi0I6rLHQnM15nFDH3x9xa0U5nAIdp3PuRGBAGmrqhmpQ+6eZKJSQzMSZXjY3bi1BeZCWLAEyccykuN9N/a0cJR7YzWPakKDH7b136tQYV63Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWTjb6KG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWTjb6KG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780161244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cQo9X/V0eNuxdkrHQS2mRphpkh2Y8s1fc9TGgc5bCGA=;
	b=TWTjb6KGKq9XHMzdL+/OLoinGY0QNCjT6MciZOwfkKzOZZatDgjZSvmGf8GJPYzcLMwfp2
	6E18ylC2Aglb2OHhwXauOFxgJDN2xSV99949gj3zo5OgVW9R6XjVrfrklWvz1aJJcx5Rvk
	BD+sQ082Eyzy9V6fUg9puA375iXwPH4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-weMDYfnnNCKCbmMFCP2o6Q-1; Sat,
 30 May 2026 13:13:59 -0400
X-MC-Unique: weMDYfnnNCKCbmMFCP2o6Q-1
X-Mimecast-MFC-AGG-ID: weMDYfnnNCKCbmMFCP2o6Q_1780161238
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C3A51956089;
	Sat, 30 May 2026 17:13:58 +0000 (UTC)
Received: from [10.44.32.29] (unknown [10.44.32.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C9741800357;
	Sat, 30 May 2026 17:13:57 +0000 (UTC)
Message-ID: <2423b34b-4108-46bd-8a05-690bc518cf53@redhat.com>
Date: Sat, 30 May 2026 19:13:56 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260527180417.4119289-1-seanjc@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
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
In-Reply-To: <20260527180417.4119289-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 5/27/26 20:04, Sean Christopherson wrote:
> Please pull a rather random set of changes that have been accumulating over
> the last few months.
> 
> Note, the SKINIT nSVM intercept test fails on some Turin CPUs, but allegedly
> only on pre-production hardware?  I assume/hope such hardware isn't commonly
> available, and so didn't bother trying to handle it in upstream KUT.
> 
> The following changes since commit 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2ff:
> 
>    Merge branch 'mbec' into HEAD (2026-05-12 13:03:25 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2026.05.27

Pulled, thanks.

(I haven't pushed my 32-bit tests yet, especially since you preferred to 
leave out the new nSVM test).

Paolo

> 
> for you to fetch changes up to c10d4616e2ad5d95553b2f0c389b4546dfacd76f:
> 
>    x86/vmx: Remove the superfluous vmx_cet config entry (2026-05-27 08:59:46 -0700)
> 
> ----------------------------------------------------------------
> KVM-Unit-Tests x86 changes:
> 
>   - Track SVM's EXIT_CODE as a 64-bit value, to verify KVM does the same.
> 
>   - Add nSVM tests for unsupported instruction intercepts.
> 
>   - Serialize the (v)CPU after WRMSR(TSCDEADLINE) to prepare for APIC timer
>     virtualization.
> 
>   - Disable PKU in the vCPU model when running the nVMX access tests to make
>     the runtime somewhat reasonable.
> 
>   - Extended the VMOVDQA test to cover VMOVNTDQA as well.
> 
>   - Add test coverage for ENTER + emulated MMIO.
> 
>   - Misc fixes, cleanups, and minor coverage enhancements.
> 
> ----------------------------------------------------------------
> Isaku Yamahata (2):
>        x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to serialize deadline timer
>        x86: tscdeadline_latency: Remove unnecessary nop
> 
> Jim Mattson (1):
>        x86: nVMX: Add retry loop to advanced RTM debugging subtest
> 
> Kevin Cheng (2):
>        x86/svm: Add missing svm intercepts
>        x86/svm: Add unsupported instruction intercept test
> 
> Maxim Levitsky (1):
>        Skip PMU portion of vmware_backdoors test if PMU is not enabled.
> 
> Sean Christopherson (9):
>        x86/cstart: Delete "local" version of save_id() to fix x2APIC SMP bug
>        x86/debug: Fix macro definitions for DR7 local/global enable bits
>        x86/svm: Track and handle exit code as an unsigned 64-bit value
>        x86: Disable PKU in vCPU model for vmx_pf_{vpid/no_vpid/invvpid}_test
>        x86/xsave: Extend VMOVDQA testing to also cover VMOVNTDQA
>        x86/debug: Verify DR6 is always empty on an INT1/ICEBP #DB
>        x86/apic: Verify LVT timer register mode reads back what was written
>        x86/emulator: Add testcases for ENTER + emulated MMIO
>        x86/vmx: Remove the superfluous vmx_cet config entry
> 
>   lib/x86/asm/debugreg.h    |   5 +-
>   lib/x86/msr.h             |   1 +
>   lib/x86/processor.h       |  11 ++
>   x86/apic.c                |   8 +-
>   x86/cstart.S              |   7 --
>   x86/debug.c               |  34 +++---
>   x86/emulator.c            |  66 ++++++-----
>   x86/emulator64.c          |  64 ++++++++++
>   x86/svm.c                 |  22 +++-
>   x86/svm.h                 |  98 +++++++++++++---
>   x86/svm_npt.c             |   4 +-
>   x86/svm_tests.c           | 290 ++++++++++++++++++++++++++++++----------------
>   x86/tscdeadline_latency.c |   1 -
>   x86/unittests.cfg         |  31 ++---
>   x86/vmexit.c              |   3 +-
>   x86/vmware_backdoors.c    |  18 ++-
>   x86/vmx_tests.c           |  76 +++++++++---
>   x86/xsave.c               |  36 +++++-
>   18 files changed, 559 insertions(+), 216 deletions(-)
> 

