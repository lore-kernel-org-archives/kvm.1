Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7E4AC14D
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999878; cv=none; b=WMRtuzhRVRbPRZAI6djiuGPknwDXzdnzHbGN3/nnykGfRP20wQN0pZYvvd6gw6U7LjNkLnmfMctVoFcn9FQSjOawz5AyNRyDuXkdtqV1m3ckbVZYqocTbbFzAHWNP1l+4GShnkmWUUynHwxH2zfgJl8l3fy3j4VUePhr80Vp9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999878; c=relaxed/simple;
	bh=B4QJF82dna8D9ggBsF8oeK2V+6NAw7hoRbDRKemE+iA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YBdox7IPh0CX3F6Bl8oJLZtHT9pKrspkjPhaHw2eHa8kA6rTBk1f9LcHJjWdZiinw0KiQYwma+YEs6nSmV7yjEuUUMCgouDwX4mUz6tWYdgXuKewur8iKMO4BitAuXR/6KOTFyFgxi1LveJjxRzLMykPLT745RLockqGwkJF7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bw7ZHcUl; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bw7ZHcUl"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd53f2b27cso38397355ad.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999876; x=1790604676; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuS+RsQ1XJKIcaJnDQOiwRD0nOJzYFvdBOhw7tWIQmU=;
        b=bw7ZHcUlYm1jgzRP4VFhKS6O36dKIPYhDyV3fP5jMhQUi6jvrPqMjgHOaxr3HcMIv1
         uAc5ozk4tAh4cuKUb40b44e0u6+Wo/2OX81YIYCeHUV+ZgMaTor+WwrdyErwYSpwIYhM
         BlHCrDAALhwRNe9exe0ozYlOJiFfyVNt9Tq7MKTE86MSqga7UmmZIrcU+yh8oYihWTGr
         2bSc+l8H9XSSZkeF4HPyS2eSx5F9mkJ/y2FRgI+x07cNG+E/+fkDNt/Ii8aDgCegY1nA
         v2RkYXA/Q5qUJiX4u5tej5HqUqXgRqy+cVmpBiBA3pvBB4RX8vpIkmB/Jstah+po9C1G
         hl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999876; x=1790604676;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuS+RsQ1XJKIcaJnDQOiwRD0nOJzYFvdBOhw7tWIQmU=;
        b=Mq1aKZo8oC96HdTKb9HAWS2gSRiW6o5Mp6Y1ax93aq+XVDS++8ZQVC8D1geFXAmA4G
         3a3siiOey62b15f+w3I8rnsHAd1C0EHCcR+1r7FB2KR2siZxQ2bz1+cqjoA2LZNW/tQI
         sU1NgpW5QMB5B7jVG9keJenr7eBDVXzm26+z5tiIq5nFqFZulYr2tkBQEPkS3OoKzqf2
         oZU+qC4L5uZGMVUiE3WeQm8WeIQwsFqCdUFGLxdwZA47Cu3nGPAU2urcd0fbNTgY6Mfz
         OSHl8qJh0J2DUId17rHELcdLidRRLr7TU3i9SCArdcO1mwVO0YJhVuO8/ieUfBn77OjH
         pbmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwADFbFjYcDrHm7UVZCBl/WIXVNCbYQEly4yNMbkjih2Rn+3P/ZsfnwZaSOLoPU5fjw70=@vger.kernel.org
X-Gm-Message-State: AFuF++kyQ3Am5TevCedq1KmPl7orAxerDlsBv4jU/CCsWaBZO1IFtSWO
	228FRMCg7TCLiVFJyh8TW2KNVb4ww+C/PvVN4UJRjpdtZh4L/YBC0JG22Jx4atc95koYXngG0o/
	TJzJVFg==
X-Received: from plbd17.prod.google.com ([2002:a17:902:f151:b0:2dd:4fe2:d786])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2349:b0:2dd:c100:4b73
 with SMTP id d9443c01a7336-2ddc1005ee4mr92390435ad.42.1789999874739; Mon, 21
 Sep 2026 07:11:14 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:11:14 -0700
In-Reply-To: <7efe2260-5c11-4e8c-812e-dd1e215ac3e4@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914181223.289061-1-seanjc@google.com> <c645070e-9829-4f98-bafc-b5d44ff2db45@leemhuis.info>
 <7efe2260-5c11-4e8c-812e-dd1e215ac3e4@redhat.com>
Message-ID: <arE7AjkOyuadAFBY@google.com>
Subject: Re: [PATCH 0/5] KVM: Serialize vCPU creation and revert vcpu_ids tracking
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, "=?utf-8?B?UGF3ZcWC?= S" <spawel523@gmail.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 21, 2026, Paolo Bonzini wrote:
> On 9/21/26 15:57, Thorsten Leemhuis wrote:
> > On 9/14/26 20:12, Sean Christopherson wrote:
> > > Serialize vCPU creation by holding kvm->lock for the entirety of
> > > kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
> > > by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
> > > possible").  I botched the math when justifying the vcpu_ids tracking; it's not
> > > an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
> > > "struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
> > > something we want to do in general.
> > 
> > Hi Sean! Thx for handling this and sorry for pestering you, but I have
> > to ask, as this fixes a regression that was already reported two times
> > and introduced this cycle:
> > 
> > What's the plan to merge this? Is this aimed for the current or the next
> > merge window? Ciao, Thorsten
> 
> For this one, but after fixing the PPC and s390 cases.

Ya.

> Sean, if you're busy I can send the v2 myself.

I'll get it out today.  I was traveling last week and got behind one a "few" things.
