Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC137B007
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854406; cv=none; b=RfVXaWkXA3XIb1pqofWSXLikD277B2EdIdXtURajjF1CSkOjdbH+LWWkQOk55nKYFVdHuYTwx9WV0/6otEzho0xfva+dzLvh9BVnBV5a2Sdg+KO0CbSHta5QyJH9z8qttN7cXM3DXsxYkBcsiNA1/dzSCBiXbNHx/5xo13FzoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854406; c=relaxed/simple;
	bh=9mw38/WNwW1LTjSnxBcc4xhixLdnlZ6cf0Ka5h7706I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eh9/rSQIVDgNmP4YHq7OX2H/NmdMzT6DG+ZNrSAcdSsbv3ZFJ40wp1DlNHnhsiT9n2uQaJo2Q0IvR/Hpo7VxTGO6Du2BpRnCiSG8MtPxWntGOSv4CrxwyhdqTaV1ktUdVaqTK2ZffbJFweL+Yonaa9rTgPQIMTJGHeHrU9tWDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jR8/Lgd8; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jR8/Lgd8"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacd6d37edso1503575ad.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787854404; x=1788459204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5x6DsCI3ug4zKS7hBUde1Gm18tVYAO0b1NSsK6HdL24=;
        b=jR8/Lgd8o/N0jCAYpiWmdzwQqpVSD2N6jH7Q1uOKAoIWSS4NTpKbeaYIBlTQpQ1Jw1
         bgOhOu5HBrqdlDMF3RTE+6DtEXgaQACOfmKTc18M2Buy7IEr9vZsoyut/zWYPNIulQm5
         Dac8lL/RMEplme8h/raqfSA7GkbreHNX0LwTgdTj/Rga80q1q+UcC5tivpyGs9NOrUGq
         hOMJtlJbr1Hc8orpaa6czEVcMJ0hdrPgFFdOMIsGzHQ5XemyIZNdyJpfLFnIglhJYKqD
         B/9fGf0RnHVTSBKqnCn/DDIK8aS+3ZLvNv8EpKtsmwPD50wgsBfsmUFtrADBkpVwPpZG
         TGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787854404; x=1788459204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5x6DsCI3ug4zKS7hBUde1Gm18tVYAO0b1NSsK6HdL24=;
        b=X2/euyGozwCxsx0FywNYryfH7Dw6tcPI0iLcij9ZFqeBE+crmC2a8R2CHelbPu9kQ4
         HbsOvji0wdEvBCEo8joNGeu5y3pYR4KaAMO/iMjouMlMWWauzaWe1qRDLFo28TpBYEPG
         NhOraXthK+oWgNmqlZDz574J38QOFK+tSOoayZ0S2Kyaqzsv1mJ6h/RYM5i7d128FXVb
         m+NOEdek0/XHbfctmGqb6FFOewSPjYKaT2pau/vCIjXorn5u1KudyxigbdNoCQkDmZpP
         JohOXp0O9/cxQPUJt4acz43HIRVp6zlC0rr4WeYS2zsaEJm2WuakbI1ue08vAbAJBxQt
         TKUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rozp905FbjYQ4GBVwUr8kcyg+IpsjrNJbp9h4J42iLlj9oVc5Xg1ktUajp72Yb+FdMvsrM=@vger.kernel.org
X-Gm-Message-State: AFuF++mW52FS4QB9pq+fcqmSbVSdig7DZ73++ak7x7YMrhDHg3fTtiE6
	d+kbU2zuDkD++dCxZuxOO4J4JHwfR22frE4WXg+BNOioiRHoG3suK1kLyDj7qqnsZBjaakttgDz
	/8/hleA==
X-Received: from plbjx3.prod.google.com ([2002:a17:903:1383:b0:2d0:1248:a5dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f546:b0:2ca:6c8:abd8
 with SMTP id d9443c01a7336-2d74df45042mr11979985ad.12.1787854403782; Thu, 27
 Aug 2026 11:13:23 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:13:23 -0700
In-Reply-To: <CAO9r8zMbhEg76dKSXWtyKf_=HFvNC3f1gX3xFZ5iPmA=9L1JVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-4-seanjc@google.com>
 <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com>
 <apBQYmmBC8lE-KiQ@google.com> <CAO9r8zOiPc=AdSZov9w5EN-WogpSTR54z8UuTd3oqKHiWCfNmA@mail.gmail.com>
 <apB0FLZGZPmAEk8o@google.com> <CAO9r8zMbhEg76dKSXWtyKf_=HFvNC3f1gX3xFZ5iPmA=9L1JVg@mail.gmail.com>
Message-ID: <apB-Q04f-3d0V_BM@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > but (a) that's still
> > a (must smaller) game of whack-a-mole and (b) it would actively hide KVM bugs for
> > flows that are supposed to reject the invalid state.  And if we WARNed to address
> > (b), we'll be right back where we are today: playing whack-a-mole to prevent the
> > WARN from being triggered.
> 
> Either way it's a game of whack-a-mole, unfortunately, whether it's on
> the write side or the read side. What I am hoping is that if we do
> miss one case, we don't crash or corrupt the VM. Ideally, we can just
> ignore EFER.LMA if EFER.LME is not set in these cases?

No, because the context matters.  Did we end up with EFER.LMA=1 && EFER.LME=0
because L1 is running L2 with weird settings and wants EFER.LMA to be ignored?
Or did we end up with the impossible state because KVM screwed up?  In which case
crashing the guest because KVM runs it with long mode disabled when it expects to
have long mode enabled is the *best* case scenario, and the worst case scenario
is the guest limps along enough to corrupt its memory and persist the badness to
disk or whatever.
