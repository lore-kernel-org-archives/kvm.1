Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902439CD0C
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482374; cv=none; b=hFtTO6QGInAMKXNkVdQIDnn9/vcyX61dYPiNURw58Tk9jXwlNdJPPrjaMSDIzrAKMllRjsJSHNnWVz38bbWNsedNb/aQkGc7SyvH7REN6mkPLpgWwbAqQTFlRKizYkNOzRCb0gCDsyLlHfNtZn8VKOII+N63Oxjo1b4lo7PqhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482374; c=relaxed/simple;
	bh=UUaU8ahNPCbsJx084Eu+GI0dh5h23JWgJk4ceCPS+bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hre60WiuyzgQbA2ALNUFqS30PjMTIny0AWVAxdFqHXj++kBkeJaR92RDQSSfO8IuVr7kW3YCqmwWFyogZgBH4UxaWguCuUSArMA9xQvtt2lx6XYGAJHcuBbD9MN1uB3yXOGjAGRSKUy2KukiNvJh9xctSBl0aKOMEEHZvu4Jel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZhs5PRA; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZhs5PRA"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so8007803a91.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791482372; x=1792087172; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GiH1A9bHWsqdCgdL/9gW1YB1NyiwHGiEa5mLSa1yf8=;
        b=SZhs5PRAAwxKWEVFz/Na/LpNteDcZxAvtQj64vc2CzR55Et8Cyj2jSWt36onr0VtHB
         ewplXZ6S9ADeJaixocZD9o0LH5Mv5vf8o0a1u+eEsWCtMJOdYH9VROSzNrj6G4raQp/N
         EyCMoxZUe/24jgmc1Va/jzhWi/UBfI2JQU47v5bedFZnknNJ+LvDlI7ULzZwu0DyiJJ3
         JSbMtJqb22VNTcd+LkG6nsnxQAz3JvT8jPhSq/iL3s7qQdaqy4UpG7Uzy194V8dxj0p2
         66NSnf2TGU5VHK+UusnZZ7tqCfMBDSwg1HcQMTQdxkqlKgKAz9KpRbtKVocJdWPt++2/
         /cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791482372; x=1792087172;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GiH1A9bHWsqdCgdL/9gW1YB1NyiwHGiEa5mLSa1yf8=;
        b=Jm9SQxJ9syscHGJ3H1zVC0T7f3HFTDHjbpA3klvjI8Dj+aQs6eEZxodBVJxFQqbuL4
         PiZDaaklv8IgU9s2w/IxJjOe+TW/1+BeGc/Mgxe/iciJ1VBpxN7o/UqkQtRJneaqz7Xk
         Z3sGchVNLcdkQqwr3j7AGT6MfJDVWTmgWhw03tRUaYdu0yNqvis+T28Xk5g6wNW59B6/
         fxFsiT9O1B2W2IKbIj3cT4Wk06DEv95jKa73ZJFitV8scBwkjsH4z+5ARXJDtSpGsBCc
         d8rpABEJvGpZxbbOQi2KINVpmuw2+d0LMIDJn7iNjzrvjgS7HQBMn2mUGBcpiS3/q6hP
         KHyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOMgSS3Nk4jGOb0IyIayIVmmsrFSQN1QdSQ3oOjwUcthZuXs7Oq+R5eJoqICoIDVqoDaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiAv7Gx6D054eIlO0Ybg/gMo0FUapx9/foUEzKSccz6HC4X6hL
	l4mBIjo8yfBkVlFz/crHlxJfQ81h3pBKEZOe1aSIh5LWB/vIMzVIFEiwPzcm3ABUvuDMwFrI7+6
	feR/cHWDngupWFw==
X-Received: from pgby12-n1.prod.google.com ([2002:a05:6a02:650c:10b0:cc7:c4cb:69f3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:288c:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3a8a0b8bfeamr5875944a91.26.1791482371993;
 Thu, 08 Oct 2026 10:59:31 -0700 (PDT)
Date: Thu,  8 Oct 2026 10:59:27 -0700
In-Reply-To: <20260310060022.15120-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008175928.732268-1-jmattson@google.com>
Subject: Re: [PATCH v3 4/9] KVM: x86: Extend CPUID range to include new leaf
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:16AM +0000, Manali Shukla wrote:
> CPUID leaf 0x8000001b (EAX) provides information about Instruction-Based
> sampling capabilities on AMD Platforms. Add the new leaf to
> kvm_cpu_cap_init() using F() macros, which automatically gate each
> capability bits against raw hardware CPUID via raw_cpuid_get().
>
> This allows vendor code to simply clear entire leaf when vibs is not
> enabled, rather than reading hardware CPUID and calling
> kvm_cpu_cap_set() for each capability bits inidividually in later
> patches.
>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>

The shortlog is not accurate. The CPUID range does not change; case
0x80000000 already limits the maximum extended leaf to 0x80000022, which
includes 0x8000001B. Before this patch, leaf 0x8000001B went to the default
case, which returns all zeros. This patch adds KVM's supported bits for the
leaf and a case that reports them when X86_FEATURE_IBS is supported. Please
change the shortlog to say that.

Also, there are some typos in the changelog:
  - "Instruction-Based sampling" should be "Instruction-Based Sampling"
  - "capability bits" should be "capability bit" (twice)
  - "inidividually" should be "individually"
  - "vibs" should be "VIBS"

> ---
>  arch/x86/kvm/cpuid.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 96a08a556543..4e626e77e6a6 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c

[...]

> @@ -1848,6 +1864,15 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		entry->eax = entry->ebx = entry->ecx = 0;
>  		entry->edx = 0; /* reserved */
>  		break;
> +	/* AMD IBS capability */
> +	case 0x8000001B:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_IBS))
> +			entry->eax = 0;
> +		else
> +			cpuid_entry_override(entry, CPUID_8000_001B_EAX);
> +
> +		entry->ebx = entry->ecx = entry->edx = 0;
> +		break;

Please put case 0x8000001b between case 0x8000001a and case 0x8000001e.

>  	case 0x8000001F:
>  		if (!kvm_cpu_cap_has(X86_FEATURE_SEV)) {
>  			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
