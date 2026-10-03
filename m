Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BF242D65
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791010360; cv=none; b=sx8YFEwoiK4pdn34bE9t1TibE/BmqOpts2G/D5WAaI04SCGV4Um/HLkVD6ZXHuZwpIJqXi/LRHZX4kkIuiN7ExJ7eRc1a0RTMZJ9BHosPlkKS5CrUJ0t2HRR5KZxY8W3u/klnsq1oVY71Fa78ES0y3Z3S+/rv773zC4GOTAfQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791010360; c=relaxed/simple;
	bh=9ndOKBqk9ERaEKLBVSNmf+3Bbqo5SKTyAkPqXtoGljk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=o4GHcYGadaOwborvvZiLAeYu53cJnWabwVTS9zQeHxf8H/1iC+opRkEQD23oz4RCr84B4jZFZ+nA3pLTiuZtCBD0mHv1JA4FMW57hT8naKpCneRhpkUwOS5wJfOwbTHfzD7IKrGyzVH3eJzmnR+0whOYMCCBg+mHerMVryQsDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEgBfqeG; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEgBfqeG"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34d2d25127aso32526eec.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791010358; x=1791615158; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fT+rzKFOrryCjv0z9CwPip/4lzX30T7RArz2Qd2Hmnw=;
        b=DEgBfqeG9Kd8/RwT5n++40FOPL921OaQZ0kwddioSq6FvTnzPicMj3H5N4mtGBVvsY
         IuqlXlgsogbtuiOY/bBsWXT6Vombem4ljGe5E7ZuCthck1khk26Np2HkwVJe7wrNr34A
         at7VMRiUj/2j11k4LIKBoX6S+hbeCQ2Ti1EAtnEkHlZLjnXhlU73t0f09holEw72jyT2
         xMa8QKZLBhqdoZiiFWq9sSYU3PsEneZRkiHAevESiErVBSb+2MTY3tS6APYJBVexHfgZ
         HDTXoRp/zisF++RMOiJ1GRDqEWnmH/fYr/FRcdOxURj5EljcymT+7IyZNrNVY5zCp2N6
         nwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791010358; x=1791615158;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT+rzKFOrryCjv0z9CwPip/4lzX30T7RArz2Qd2Hmnw=;
        b=omYXX61L/1PmOG0wSCEnB3ND87tIZzkGNOW5CjWyNBi4Zl6KxqCPPyV1v35tJBT6ok
         hbRtBRsE+0ZgNxGIqvYSXIf1POV1mH74dhRy4Mv5aFDUa4lTcD4RKB/5Y/IHr5lSNqEs
         MGI7i/bHG1imXqossQ/FBRLtExQxE8Ch9SRq97PnO2NyFy/tLiDQtkZ++EXQwGPzVIG2
         qzPKTWEWKPVmmPNgrcAea+L0ZyVQoubgWBTnrbi1sndnnqk2szXg8UD5PgY5d0Z9MYV1
         gihqsdhlKF0zSwdtytyN1BC3v1sXwbHxhzTW9xJUa1EtO2nnddyt6fSp+yI1VZ6cZvaH
         TpQg==
X-Gm-Message-State: AFq9FYIIj+VsI3M894b8ycITan6trLLYgzKguvDMJkJnkAPGE/zoerCn
	q4WSzGKTbutq/3tfIGEsk2uBPE8M7MrD6jV0YP8xfBgAEqa3Bdml4On4
X-Gm-Gg: AYBFou1NK0U+/w6p0r2GzEpfL+Fqx+nQ7lK4XjyIESAxAe+thoXI96BoTYkL0k7DvSv
	u2ibgRdvnOWvCTeovTAJGKFq9G5IyEickCCfPHbJwXaNpbzU4Nl+EDYD/KBwU7iIZAW43OBOihG
	HEpSobnjIMDJoBglx+4CVmaTYQWNaCcqK5CuCyV2cw+gLPoQfsjMyLvBTw3UQNtk3u2CSU350ia
	5MlRqe7dMrpyJ4fBR+2UkgwTbP9QNTpJAuBQGbW3g0aC2MTSnQye8w8O+je2bMj1X1Mc9CB67lh
	ZL+7BRBhRHiYmaNA3+5UlWWp8iaQJgIyP1N/wrBB7WzVFpLr2TM2AneuOksZjny28Zmk4Rl0hhf
	xk0GMV2mEVghJ9LDyuQ+pVBajF6msY1E04yd0kNmx+MKdjgvLXEhX5m0ozHSjwB+9Aw81qfNQJI
	vyxLLT0ktchJXwsbyk/uT5l+qKKqicTUsdFIQ6zdUk8CxTxUfKf8gw0xSbWCyriBxsC3ZK7YW5k
	TUTvsg4802W3CovCPclhDFgtaysYw3rCzH87RfjZrfi12Y+nFZbA5ky5vk2SYIO
X-Received: by 2002:a05:7301:1a03:b0:33b:bea7:84dd with SMTP id 5a478bee46e88-34f21994b42mr5626972eec.34.1791010358101;
        Fri, 02 Oct 2026 23:52:38 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34ef98d925csm12467103eec.0.2026.10.02.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 23:52:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <asAydfQLscU6rXQL@google.com>
Date: Sat, 03 Oct 2026 12:16:01 +0530
Message-ID: <h5j3jn86.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com> <asAydfQLscU6rXQL@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Sep 29, 2026, Ritesh Harjani wrote:
>> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>> 
>> > Hi All,
>> >
>> > This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
>> > radix MMU).
>> >
>> 
>> Hello Sean,
>> 
>> Just wanted to check what's our plan on this one?
>
> At this point, I'm not going to get a pull request to Paolo before the normal
> merge window.  I was hoping/planning to get some early pull requests to Paolo
> this cycle so y'all could build on kvm/next directly, but that didn't happen.
>
>> Are we planning for both PPC pre-enablement series of yours and this one to
>> be taken for v7.4 merge? Do you think this can go in too?
>
> I'd like to get at least a subset of this series in for 7.4.  If I'm reading
> things correctly, all of the hacky changes I don't like are for the
> kvm_create_max_vcpus_test and hardware_disable_test.  And as called out in the
> final patch, "fixes" for PPC really should be ordered so that they land *before*
> the tests are enabled.
>
> Actually, better idea.  Limit patch 1 to just TEST_GEN_PROGS_COMMON, then for
> the addon tests, bundle the "fix" with the PPC enablement.  AFAICT, except for
> the kvm_create_max_vcpus changes, they're all pretty small, i.e. bundling the
> PPC support with the "fix" shouldn't be too painful, and then we don't have to
> worry about ordering.
>

Sure, will take the suggested route then. Will bundle the Makefile
enablement change and the needed fix in the same patch to avoid the
ordering issue.

Also note - I will open code the TEST_GEN_PROGS_COMMON and will skip the
kvm_create_max_vcpus (& maybe few others like vm_types_test) from that in v6.

> As for kvm_create_max_vcpus and hardware_disable_test, drop them from the initial
> enablement so we can get the core support landed, and tackle them as separate
> series post-7.4.
>

Sure. Will drop these two.

> As for actually landing this, the easiest thing at this point would probably be
> for me to grab the patches in a dedicated topic branch that's based off the
> kvm-x86/selftests branch at an appropriate point in time.  Alternatively, I
> could provide a stable tag and someone else could grab the patches, but other
> than it being a little weird taking PPC changes through kvm-x86, that's by far
> the easiest approach since I'll be sending Paolo pull requests anyways and can
> explain the dependencies and whatnot.
>
> TL;DR: what if you post a slightly trimmed-down v6 and I take it through kvm-x86?

Sure, Thanks a lot Sean!
Let me post v6 with the suggested approach.

-ritesh
