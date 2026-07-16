Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7B3B27ED
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186701; cv=none; b=SGxVOCocGikIp881ZMR5U0jIBn4/CfXrY5xQ0H43LA9mMvougQnzl7AQbL++yno8OajF0UNAYRVYWaCkvz69a4Gr8yYAxQWYShfmyPoiaxtYZ4SpJPHtVgpUetQoM60m+rW5oJ/m6qtd72qeHlmDIf4mAkka0DWnfrO47MWlyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186701; c=relaxed/simple;
	bh=3fHABkGXQaoQgwZMv9vEx60yrevs8bIgtzGJtW2Fl3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/1qf1KqQcHj8sg/fGNud2fkqLh6hMTNCoZWz2C5x3F9lwRnDVM+6j7lt0hWsCW5ijI/qGjjZhlIQW39NHaR9Ahg+TCe0BMmk4aXGiQ1ghahmJK1Q9P03jpJXCgUKhyKVNSPsEyso5X8VSH7ejQYWrvANCeNC8ecEWKvgVKjJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgkJDYLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgkJDYLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784186689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/hLx6Tv68/4euzSsx8lMyhbgvKWs5mgBgDORGTSs0VI=;
	b=ZgkJDYLnoeqPxWAqhE3APGlzcXkbR40s3RSr8dongbTneoWSFs+2vzAWXXHYcSH3B6C0i5
	21nB0bMK9M/di599kRHnZ+O+D+3I/+z+Z+Vl4YqyneXYEvSZWNaXzNdb1w4Es/sKL3x6bw
	A4if9qdh4BjJplsRG6zSLDq8uRk8baA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-PLsjWvdvNzW4TzqdvCbyBA-1; Thu,
 16 Jul 2026 03:24:43 -0400
X-MC-Unique: PLsjWvdvNzW4TzqdvCbyBA-1
X-Mimecast-MFC-AGG-ID: PLsjWvdvNzW4TzqdvCbyBA_1784186682
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 493C1195605C;
	Thu, 16 Jul 2026 07:24:42 +0000 (UTC)
Received: from [10.44.48.38] (unknown [10.44.48.38])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D051742E;
	Thu, 16 Jul 2026 07:24:39 +0000 (UTC)
Message-ID: <5f646121-baec-4f1d-893a-266a10f570f8@redhat.com>
Date: Thu, 16 Jul 2026 09:24:36 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Bump asid_generation on CPU online to avoid
 ASID collision after hotplug
To: Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, seanjc@google.com
Cc: yosry@kernel.org, naveen.rao@amd.com,
 Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>,
 Srikanth Aithal <Srikanth.Aithal@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20260715063506.672432-1-nikunj@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260715063506.672432-1-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 7/15/26 08:35, Nikunj A Dadhania wrote:
> If a vCPU stays scheduled out (or blocked) while the last pCPU it ran
> on goes through a hotplug cycle (online->offline->online), and the vCPU
> then resumes execution on the same pCPU, then it is possible for it to
> run with an ASID that has now been assigned to a different vCPU,
> resulting in stale TLB translations being used.
> 
> svm_enable_virtualization_cpu() resets asid_generation to 1 and sets
> next_asid to max_asid + 1 on every CPU online event, including hotplug
> cycles.  Because next_asid starts beyond the pool boundary, the first
> call to new_asid() after an online event always wraps the pool,
> incrementing asid_generation to 2 and assigning ASIDs starting from
> min_asid.
> 
> Consider two vCPUs from different VMs, vCPU-A pinned to CPU-X holding
> asid_generation=2 and ASID=N from before the hotplug event:
> 
>    1. CPU-X goes offline and back online: asid_generation resets to 1,
>       next_asid = max_asid + 1.
> 
>    2. One or more vCPUs migrate to CPU-X and call new_asid(), wrapping
>       the pool and consuming ASIDs starting from min_asid.  Eventually
>       vCPU-B from a different VM is assigned asid_generation=2, ASID=N
>       — the same ASID that vCPU-A held before the hotplug.
> 
>    3. vCPU-A enters pre_svm_run() on CPU-X: current_vmcb->cpu is
>       unchanged so the migration branch is skipped.  Its saved
>       asid_generation=2 matches sd->asid_generation=2, so the generation
>       check silently passes and vCPU-A continues running with ASID=N —
>       the same ASID just freshly assigned to vCPU-B.
> 
> Both vCPUs from different VMs now run on CPU-X with the same ASID,
> causing them to share NPT TLB entries and producing stale translations.
> 
> The collision manifests as a KVM internal error (Suberror: 1, emulation
> failure).  The NPT page fault reports a faulting GPA far outside the
> VM's physical memory range — a sign of stale TLB translations being
> used.  KVM falls back to instruction emulation, which fails on
> FPU/XSave instructions (XRSTOR, STMXCSR) that the emulator does not
> implement.
> 
> Fix this by incrementing asid_generation instead of resetting it to 1
> in svm_enable_virtualization_cpu().  On module load, asid_generation
> starts at 0 (memset) and the increment produces 1, identical to the
> old behaviour.  On subsequent hotplug cycles the generation advances
> beyond any value a vCPU previously observed on this CPU, so the
> generation check in pre_svm_run() reliably forces new_asid() on every
> vCPU after every hotplug cycle.
> 
> Fixes: 774c47f1d78e ("[PATCH] KVM: cpu hotplug support")
> Reported-by: Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>
> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Queued, thanks.

Paolo

> ---
>   arch/x86/kvm/svm/svm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 91286d46d13ad..c2c6487bd5bd1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -571,7 +571,12 @@ static int svm_enable_virtualization_cpu(void)
>   		return r;
>   
>   	sd = per_cpu_ptr(&svm_data, me);
> -	sd->asid_generation = 1;
> +	/*
> +	 * Bump the current asid_generation value to ensure any vCPU that
> +	 * previously ran on this CPU sees a stale generation and is forced
> +	 * to acquire a new ASID, preventing a latent ASID collision.
> +	 */
> +	sd->asid_generation++;
>   	sd->max_asid = cpuid_ebx(SVM_CPUID_FUNC) - 1;
>   	sd->next_asid = sd->max_asid + 1;
>   	sd->min_asid = max_sev_asid + 1;

