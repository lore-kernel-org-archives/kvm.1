Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57183FA5D0;
	Tue, 28 Apr 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374750; cv=none; b=qZ54M+0zN415VIp2iYZSv3TVM3kS/CGWi+PTdW6EJSlEpNAQxzsRPt3jQ/trfpBsTKTlrCNM9NFFk33d7I57yxPy2OOfUUE2qJumCNCUdW9wgUiEIE4t67ogDkwUp7xJE9R4LQjsJhNymCazxZcylI8nw7L/5Dc1SD6cGf+dZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374750; c=relaxed/simple;
	bh=XX69wiOzbVRUJjSaG+x1aZYGD+6IV+qLyX84tRYKeTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIAnFOFYsEqVJ8myetyulBX9sWWVYNiM0ZFstHraUtTc8W64qHuIFJyRlR4QXN7jTovP4tjdh0lIR2RlA04qyrBUK4/jfDN+Eb5iX3HwykuAVamKEZr9A12ysHRvO01skDLqdSSHjuQWwU6SZWiO0q8hRjuqP81yCJZWhJpaCvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=oYJMzxXF; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oYJMzxXF"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AA741200CBE;
	Tue, 28 Apr 2026 13:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777374747;
	bh=XX69wiOzbVRUJjSaG+x1aZYGD+6IV+qLyX84tRYKeTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYJMzxXF/BtlXo6xWOq5bqnNRdixAViOWfyaXZF/PqENtHkTb+niVl48UKPKzVMK7
	 GiVD6/WUYanSf2nXT3wgSYGu+/Sag3w5lENzglR5Zq3jlyr3Vyq9lhooK+wqHdUywp
	 mLrGDJvohEXXuL7WImXMakL+kwCKxviDEQ1TKCchH/ji/30A+zA8G/oF40HV00R81o
	 VQ572cPn8DnBw6x+RhmpReKzorwXEBToznMuPqCHqofJ+gLCLkLeVExBSGekFq8KZC
	 5Jym/6K8L4o/WA2nDaxJUeEVyrpSglilSDjD1hnNIm0cPog6d25eRraVe7MVVRiyaH
	 KARk60WmCzBmw==
Date: Tue, 28 Apr 2026 13:12:26 +0200
From: Joerg Rodel <joro@8bytes.org>
To: Melody Wang <huibo.wang@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 3/7] KVM: SVM: Inject #HV when Restricted Injection is
 active
Message-ID: <7sewxapo7kapbfxw463crzltkojmylmlldtqxdzhaf4bnhecz5@vzn2nemcgqak>
References: <cover.1777048608.git.huibo.wang@amd.com>
 <954d023cc355d1ab867c7f983c8fa830b29ee659.1777048608.git.huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954d023cc355d1ab867c7f983c8fa830b29ee659.1777048608.git.huibo.wang@amd.com>

On Fri, Apr 24, 2026 at 05:42:07PM +0000, Melody Wang wrote:
> +void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct kvm_host_map hvdb_map;
> +	struct hvdb *hvdb;
> +
> +	if (!sev_snp_is_rinj_active(vcpu))
> +		return;
> +
> +	if (!svm->vmcb->control.event_inj)
> +		return;
> +
> +	if (WARN_ONCE((svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK) != HV_VECTOR,
> +			"Restricted Injection enabled,  %u vector not supported\n",
> +			svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK))
> +		return;
> +
> +	/*
> +	 * Copy the information in the doorbell page into the event injection
> +	 * fields to complete the cancellation flow.
> +	 */
> +	hvdb = map_hvdb(vcpu, &hvdb_map);
> +	if (!hvdb)
> +		return;
> +
> +	if (!hvdb->events.pending_events) {
> +		/* No pending events, then event_inj field should be 0 */
> +		WARN_ON_ONCE(svm->vmcb->control.event_inj);
> +		goto out;
> +	}
> +
> +	/* Copy info back into event_inj field (replaces #HV) */
> +	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID;
> +
> +	if (hvdb->events.vector)
> +		svm->vmcb->control.event_inj |= hvdb->events.vector |
> +						SVM_EVTINJ_TYPE_INTR;
> +
> +	hvdb->events.pending_events = 0;

Does this also need to clear no_further_signal?

-Joerg
