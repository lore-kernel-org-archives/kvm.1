Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48528150F
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812655; cv=none; b=MnHS+qbCVdEcI6mWcZ0r34pGaTbOBndH6Ty8Mh0TK6T8MVYiSbJ0f374kf+FanbuG/5+ouV83PwUoD1eIptktBlm5cJ2J4U4JAR2tGhJlxfTdTRHkRIQqa/XWBowyxS6PxeVxr/CmVvBiIX2kbB5PGRx6sI0STNmCnScubYzKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812655; c=relaxed/simple;
	bh=5jDAEeye+HSumteDGl+iXNwiGyxalx2MEHSWTkj0pDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxSNiW3NEFEYIPKPrRnr2XMjinhtf2wU2WcA0cQrer7CyQ1U7Bt5lTJJ3Srn0iqMHQFAUY1wUzuk/mRtzM8THi2wjQGdAqWLDE6t2d09CDQv0Z+NJ3+yfuUR8OOkERmLgGqKhMS/K3gfQqTNjGc/VeYORAMhULghsydIC5hWkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZvy5j/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZvy5j/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654DFC2BCB0;
	Tue, 21 Apr 2026 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812654;
	bh=5jDAEeye+HSumteDGl+iXNwiGyxalx2MEHSWTkj0pDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZvy5j/gp349KEY4vhlJ0WznhmYnGyspFm7xjqRRKs/+KI/JYo64ekLzgxXQVMzor
	 MfLyEQLhqwe4HS6PNfQrKr6XDvRUOe162XgwljoMS/UVBOkKPs9Q+3hSGWt1fcSWmt
	 UGr+4LQKDTen2Tu5BefEXbWmWKvt6ARsE/x2cDdtgFZSkgKCrFw37UlB8qijcCGxHT
	 AAMU08PANn2tEiQM0nMkQUPm9yvOBYpvDcl4rg/P077h6ug18epjjYPa+q2UJQ5xFH
	 9csd2uVAMofqpuzHpdGKaUaVdKG6w85Wh+sA/3GtDNDuurcP1U0TWY9eKovgi3qVZs
	 94f/wMy7acGDQ==
Date: Tue, 21 Apr 2026 23:04:12 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, kai.huang@intel.com
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Message-ID: <aegCKy-4wxRq2jou@google.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407063245.2755579-8-nikunj@amd.com>

> @@ -3253,6 +3278,54 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> +		return;
> +
> +	guard(svm_vmcb01)(vcpu);

Why do we need this? Why not update vmcb01 directly below?

IIUC VMX needs this because it updates the loaded VMCS, but the VMCB is
just memory.

> +
> +	/*
> +	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
> +	 * code, but in that case another update request will be made and so
> +	 * the guest will never run with a stale PML value.
> +	 */
> +	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
> +		svm->vmcb->control.nested_ctl |= SVM_NESTED_CTL_PML_ENABLE;
> +	else
> +		svm->vmcb->control.nested_ctl &= ~SVM_NESTED_CTL_PML_ENABLE;
> +
> +	vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
> +}
> +
