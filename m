Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE083C4555
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980728; cv=none; b=eAzcSoUaCpz9G6avZm2HG/prkdGSQuMJj692VIFvEYwTY3aXUjthQMD1JiIE/zwHkQWbCG3mCO7MCXFXx2Zk0BgQpbdfDrmwrq8tDVRWTADtmRAfLFdoJTkCdBaVpEZkMCCNSl0cxjHAFjIkjTkzJE/vvrIRdnNKBLsSUkBPnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980728; c=relaxed/simple;
	bh=cKfSEMOPoL9tlZ6wipUo4X013hFwDlMQ81qIU9OU1aY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vcm5zljwCa8kbVzIGr27sON1KMa79UTcjQScD8FcIcyuEfL3Cm0cHdquooLLeRCHC3Oq+pj6xSM1dhngF1grpcYjtynY4XiRQYfPpGW4GLsPgrbiG2DBS0u6vURzU3c15QM3CMImKE3ILBmgAqCJMIi8T0tL6Xw5wRWOInQ6xLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYbmwdR9; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYbmwdR9"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8886059d3faso140416b3a.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790980726; x=1791585526; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FKzhc6JuX9pGuBJ5sRMzCjJd9/g4im8E9bMuOULVOQ=;
        b=WYbmwdR998NStm33eDkN48ceZOhW1KnfMcow2ta6nkcozn0Qkerh0TCpuzllP9VFME
         YvL+foBD4u6l25pJs3ouilY04u7Rm5KSvryxjzM0+0kiNn196FeBGbeoFWLqJYhcmlxP
         F9JqPS3XyyzbvLE042tZ3tHfbVP8Y58NVYU/R7CbKPkRrLwM5XrHixGw4hgF04N0ox/g
         iEEcGZ8yGfACAKPh7iZsjmxj5ZZI06812dkOw4JB+jVHRfBgHSX8gzpXqluS8yCfzYz4
         9GmVgawPixHEpIg2hWsTsllAambxqLTXhM1xRHfxWROxjXns75nfTsizC1AZ2wERRFXa
         Eh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790980726; x=1791585526;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FKzhc6JuX9pGuBJ5sRMzCjJd9/g4im8E9bMuOULVOQ=;
        b=aPs7XIfBn9T5AknPGUxS3ROPwRUFLfZNLXvbHMX5K+h1IxKfGeILYOipm4gVwI5Ves
         xe4NTiwLzdYLYa2yk5FYPZKgEvHxuZnK9qFZZPuaU6OpCg1EL4S3ZD5Yztbp5Xqw0jEX
         7+T4QMPJWp869jpVbtHt4HNPmcomwa3iYV1hDOGtvz+kGLboPFSCN8VM7YdTFmKuZZkf
         3hFw2TLQ4JKkH9Wxz7jBZX/BEYkBmTEOFTlsI40gG+Dc3iNkvQBQ/hIfX3O2TRBJZ3SA
         7+iMDUHuq91IcfsQgjvclR8gwuZzYmxf4gvcpIF9W2aLU77zImcSTzp3rzNwb42SI5Dl
         oZ2A==
X-Gm-Message-State: AFuF++nxtlFFz1dkzZdzA1Q6R2JfA46EeX2/3N4mEC2jFN9PTr2FgSdj
	Yxdo0JL/sDazhkkMaTQngIMj9oHvrJKXaY0YwsDFnaHg/WksjSDDH0cs3AgrFin7QG1xMOv1vhF
	ZdN9LRQ==
X-Received: from pfbhu35.prod.google.com ([2002:a05:6a00:69a3:b0:883:f59:2478])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc1:b0:886:301:cb7d
 with SMTP id d2e1a72fcca58-88af54f7783mr3790819b3a.11.1790980726304; Fri, 02
 Oct 2026 15:38:46 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:38:45 -0700
In-Reply-To: <pkxwkffc.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com>
Message-ID: <asAydfQLscU6rXQL@google.com>
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 29, 2026, Ritesh Harjani wrote:
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
> 
> > Hi All,
> >
> > This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> > radix MMU).
> >
> 
> Hello Sean,
> 
> Just wanted to check what's our plan on this one?

At this point, I'm not going to get a pull request to Paolo before the normal
merge window.  I was hoping/planning to get some early pull requests to Paolo
this cycle so y'all could build on kvm/next directly, but that didn't happen.

> Are we planning for both PPC pre-enablement series of yours and this one to
> be taken for v7.4 merge? Do you think this can go in too?

I'd like to get at least a subset of this series in for 7.4.  If I'm reading
things correctly, all of the hacky changes I don't like are for the
kvm_create_max_vcpus_test and hardware_disable_test.  And as called out in the
final patch, "fixes" for PPC really should be ordered so that they land *before*
the tests are enabled.

Actually, better idea.  Limit patch 1 to just TEST_GEN_PROGS_COMMON, then for
the addon tests, bundle the "fix" with the PPC enablement.  AFAICT, except for
the kvm_create_max_vcpus changes, they're all pretty small, i.e. bundling the
PPC support with the "fix" shouldn't be too painful, and then we don't have to
worry about ordering.

As for kvm_create_max_vcpus and hardware_disable_test, drop them from the initial
enablement so we can get the core support landed, and tackle them as separate
series post-7.4.

As for actually landing this, the easiest thing at this point would probably be
for me to grab the patches in a dedicated topic branch that's based off the
kvm-x86/selftests branch at an appropriate point in time.  Alternatively, I
could provide a stable tag and someone else could grab the patches, but other
than it being a little weird taking PPC changes through kvm-x86, that's by far
the easiest approach since I'll be sending Paolo pull requests anyways and can
explain the dependencies and whatnot.

TL;DR: what if you post a slightly trimmed-down v6 and I take it through kvm-x86?
