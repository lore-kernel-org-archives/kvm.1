Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068902F8EA4
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103550; cv=none; b=p9JMiHT5OLzeJNnaWYTH2FQt/2t2fGcSzmF++5ZWuLF7avE1G0ochQlqOGxuBrhhr3j4zZAxe+aRDyJoXfljef/qNxpH7D2XQ11cMg7HnNNSgbNIu1GfaEk2SwYVZ1v5jT8iiEHdbSOk3dCsCD1yMxKdg+VS1uffIecOAlwhB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103550; c=relaxed/simple;
	bh=Rb2vamw9hZSFDhIwOla7JE+bNgr/bCVaaW2mS7Y38Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNnS7eAVSaAXBtYr9ZGjz50sW3xiWZvqMPPnzCHFpXjCPd00wI9ZUMMtAks/9vZAzZQk7ZYrqQL//T49nAqDXeX73cmwwtOIlT3j8ByYC6KuO2eJcQk2FnMqrYR3CEqthAtMluRNSX69MEq7salO79pJn2kUBteJmGmZS1FfK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbmJiSEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbmJiSEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0255C1F00A3A;
	Wed, 15 Jul 2026 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784103548;
	bh=v4cntppyKkMahSCtsvhPYtE59WHDOJ4aGJgYd/b1x6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GbmJiSEwYygrH5HIRo9SL4osFlpdFQ6JZckWuJLXgpEK3T/GpDkGXuYF1KKzKxLEL
	 U0zPFCloO1hqvXpqW7dPycXM5WkFBQ5Jwruk7F2VWJkqy2/0vrZeRVqhPbRYm4vwRl
	 TqUiH2nckJDjJTWLBYd/WYYn/okXUAkNKgzLjk9+ZDqLufxHY9n1ItBO53LcZpCAl8
	 JDRs25c7+aBO2rzfzS4cvWxdgYXJVZtrFj5uN0Tp//8fUdUGrtZmxEa+3B9YqliVPe
	 yuxT4+TuH6zTfW0eObeD6AXYNxAUvKq8ezzudpJ6iQYWzUW9qCptwtTwv/yloOgxMJ
	 ti9Ahe6yWgyYA==
Date: Wed, 15 Jul 2026 13:46:30 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	yosry@kernel.org, Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>, 
	Srikanth Aithal <Srikanth.Aithal@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] KVM: SVM: Bump asid_generation on CPU online to avoid
 ASID collision after hotplug
Message-ID: <aldBh9GummZYUayT@blrnaveerao1>
References: <20260715063506.672432-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715063506.672432-1-nikunj@amd.com>

On Wed, Jul 15, 2026 at 06:35:06AM +0000, Nikunj A Dadhania wrote:
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
>   1. CPU-X goes offline and back online: asid_generation resets to 1,
>      next_asid = max_asid + 1.
> 
>   2. One or more vCPUs migrate to CPU-X and call new_asid(), wrapping
>      the pool and consuming ASIDs starting from min_asid.  Eventually
>      vCPU-B from a different VM is assigned asid_generation=2, ASID=N
>      — the same ASID that vCPU-A held before the hotplug.
> 
>   3. vCPU-A enters pre_svm_run() on CPU-X: current_vmcb->cpu is
>      unchanged so the migration branch is skipped.  Its saved
>      asid_generation=2 matches sd->asid_generation=2, so the generation
>      check silently passes and vCPU-A continues running with ASID=N —
>      the same ASID just freshly assigned to vCPU-B.
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
> ---
>  arch/x86/kvm/svm/svm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)


Cc: stable@vger.kernel.org
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

