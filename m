Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89904BE44F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005990; cv=none; b=JlfXNF076WBBXhBYOLwf4xvJLiREax1Yqy8GtDBnhQlMP5NNHaDXr1UVS4ZUXoI9nusx6d0g4gjj7d4r8OwYTdJHRnlw7yqwitdfZCoZLZgRiZL14TRI5QIuNfr6XirxalT4U4vZk78iE2dOBwtyWZUlsQHVtXFFAvsxuleSG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005990; c=relaxed/simple;
	bh=deE4L1phZlstjUwtD/hOmh7Gl6v0yYFFKPYYt+wx6l4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ko//MMUjnx6ZIl8/4tUaI+mBqBpJ9joGfHekP5+W5ThRg8jNzgPknw8m1dv0rw9xlnVyk32kwDa5rHrdGcOwikI5vLrBms1VOp3MWVvM6dRZGo2qdGWxF2pUOsR4ZLUcwTZlJw2pQ2wc8knQdCVqutv//Q52a75gC80y/ofajZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBsqlHhe; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBsqlHhe"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so3988994a91.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790005988; x=1790610788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqyNAjUM/X3Er3N+3LwH1+bQva2o+MZwhfp2+qk6KPs=;
        b=FBsqlHheuwCYW6f1SJ5Ujk8n6Drypp4VByQkBkPmSSJY9Zq9p6DKNTUiIVPdYNHgog
         K8uzav7yEBkSNjbViuBIQBTNA0HMG8cQIpN7V4mEBwD6SIFiam/Iwp+U6YqELsg/sBYu
         gzKSRJ/RTo4grznGe2NHbV6U6BifcYnFK0WSxvlKL8RobZ3Y05MLQbzxu8uE8caXAs8x
         C5ySAfEkNEoLZRm3NX116AxbisniA9YHgmbRd2ufGSAnsbmLmtlvvBTWvieyKw6reOR7
         nC+3WcwmOcUIAilrOf+G7HWLayhELtFuAARrmMfofnpFrqi0Eq/EwOpKDEgppqioe2Y1
         M7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005988; x=1790610788;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqyNAjUM/X3Er3N+3LwH1+bQva2o+MZwhfp2+qk6KPs=;
        b=vEF2iy4Bl68yAYSyt/0pvVQ3ybcQHId+9QRR8kDUvUEcQDYLl/dJpMLqLANQmFHiOo
         7HvUoPzqBNAlssdZMLQt4prwyvLPv77nWj5khy7T6zW/3X7n+zXKyI39k8nXitmcxyFw
         FHA+Toy5WG9pBFEqhxSQ6wuRIW1PcF6wK6/6Mha/shT4uiM6ejUOG+H8DcwEayzmUvyS
         WbybibJ40ar3001hZtHjuR6EIYixA+8GoEaqsTNuQ4AsIgx6H6XmpsHAmFklUxMDuyEA
         2UmAYAa5pbwE7OvGiJeQcJKcej24JeArsXQX8DDfivdYmGIXhD1wJwpRRh7hI+fsx0xc
         zaTg==
X-Forwarded-Encrypted: i=1; AKwUvBxGQ2wxINE1OlL5x850S0AbgLTBDukthZPSf/T3CnI6HRocgCFe8FsbZMQdZFRhcz8XF5s=@vger.kernel.org
X-Gm-Message-State: AFuF++meTeKyXZS5O+MW6xRGI15dHy/B6MQcUQzE0K492CFKbZUM3EiR
	nTtG/YeNrjiBERFo64AFZmjTVQoVREPlirY3Zlb0dOmIkULetjMzCNUBLAg4hm/oP8zDuJzMS1i
	VCfLd1w==
X-Received: from pjqo9.prod.google.com ([2002:a17:90a:ac09:b0:3a0:3aee:4edb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224c:b0:39e:4c80:f67c
 with SMTP id 98e67ed59e1d1-39e54eb71e9mr16522971a91.27.1790005987577; Mon, 21
 Sep 2026 08:53:07 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:53:06 -0700
In-Reply-To: <ac24c392-c7bd-47dd-a055-ea5f46cbbca8@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818234238.618158-1-dongli.zhang@oracle.com>
 <aoVDogaO_0IYZQwm@intel.com> <ac24c392-c7bd-47dd-a055-ea5f46cbbca8@oracle.com>
Message-ID: <arFS4k_G3mukB-s9@google.com>
Subject: Re: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID together
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	joe.jin@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, Dongli Zhang wrote:
> On Tue, Aug 18, 2026 10:48:18PM -0700, Chao Gao wrote:
> > So the goal is to avoid a _transient_ APICv inhibit in a corner case?
> 
> Yes.
> 
> > 
> > If so, please spell out in the changelog why it's worth fixing.
> 
> Regarding "why it's worth fixing," the primary motivation is to avoid
> unnecessary APICv inhibition and reactivation, ideally throughout the entire
> lifecycle of a VM.

That doesn't explain why it's worth fixing, that just explains what you're trying
to do.  IMO, serializing xAPIC<=>x2APIC transitions across vCPUs and conditionally
taking a per-VM lock in vCPU context is not at all worth fixing a transient
condition that requires hitting a small timing window in a relatively rare, slow
path.
