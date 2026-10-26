Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055393;
	b=x7kIBAEz8Xv3G4f4duH2+VACxk6BtTea23wpCxwY/FK+aKj9RKjVIDpo1nE2fWFDnush
	 KzoJWYrA37mvKq6SvsuluLo6ZXZJ3INPTjDoBa5v2yPNcEYEtiWuMQP4AY/W6uRkgdUpU
	 /f6RHWSYvLp0oeyf0qRwo88o+bWDjvMNmm0QxHt61/+shx7UiSQgHyBHXnbshoZMBexYf
	 TjlcGBuVvURPU6/lHwqw81wnyJu8qG7pKyZVxGLDeWdSmGHSQG2Gq5FJqEuPJzgN0zQ3P
	 pUj5ox23JOE+1N+N30nv30j9IBn2MjmZpra/S/zmastAqJPhx06/A/j7ZogQE0DFA6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
	b=4xyM/V+0Lm5mGftf6QrGmaQW9ZgYfeqNGXNsKM7RdKF4v8Q4i8aFdIDaNHehEIOhAFB3
	 xxCe0FsZ2521nyv23ZC8JGjKnE144ILcX77gZRIQQ6pfIepS4QK66YGM5/PbJztAl30lR
	 +wn5kXesLcEFXupFU1S4mvoy0jLkJ60lgeKK3TembdfaDW7d1sv+rT4QEJjQG1I567L/z
	 pKUdNeTRLA/WNlb0t0Exj8bdUy+RgnwKAhvsQd5IHrgmAeqs8wU94e07EOKk3EKAsktUG
	 GJ8Tyr7x2SxUdUIxAxL4mpQAQd9c7mXyaSgrjO1x7LBd0ZL7PivCv1ZY9Oz+quDQvnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D582606A325
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 22:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D582606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c423b145922so479998066b.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 15:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055391; cv=none;
        d=google.com; s=arc-20260327;
        b=cY2Lac45+/9JJKBUQ0VRTtr3YH+4JZ9iHsu89NxFlG7Pg3XdnmbBtUmOW6PBIMrgN7
         ngIhZG9uY6Dq1XtEukPxXw020Gab6kGPKemLhIMJQ7WdcbIMlq3cQv7jy4h9jhZF5cL0
         T3cnsEeZ45QSMYJI1kAbWnc+WQf1TF9x/BU6JIlxRChXji08VXe64j/G4v48B12ilfgL
         rpgqD7hII4KiS5wNSzssdWINg7+Z5Ip3YyXituGgtZV5/v/T8Hajk6EDIzp02/htsb0O
         ZIUXA066EXLry5NVmWKdTd1OX0+/OP/sLdCk1AvF6uASTMjMZ7UIty9J5SjuyXUkLvdc
         AbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        fh=gjQnyH4gMxkDVjuRnVxsFVR/695HDrTh1NEYQDmII7A=;
        b=L0QvGSJNW7OZZTv7CKy4EwuFiX8snp5T5x8gYt30UDEiI8oJXwtPQSbgZzxwbcByDq
         bGt+YkzeDdRBntcL7AsEHb4mYFr84CXIennJ+GyfIo3JTJKGH16wTTfBbzvzijSF/CD+
         YCItHOStgRUyU3GS+Uo7D/OqokcG5irmqNbfftLj4LcktvZCo57DMT63Eq4IGJZmQFuT
         qAeZjzfzIpYHJTlmXeECJEbsWAeT+YkxSF6aM/iQmtUNtRNt4DKIjg/QH4YN/XA4qHv4
         /NOEOX3LcUpEwBTLtC9bu7btKHnaPjvqMvhPCso5sbmwyz3G3ro9VCUXrk8NQu1ickR6
         G3JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793055391; x=1793660191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=s8grGiR3jmOk9ry50/nEnZjaxWjWOPyppi2m4MHQTMfb5el8k0obk5/UMSWfPsQmIM
         HPtLzsEa12OcSsVXiRmiCNw+UUDDo1UYyS6DiU9bwXoKmoGF82ns9DjJzrfs9pJWdjkT
         dIxIeAf/R+LNQl/XTj1bdocyLOLlTkNfh75pW2KuZcZpn6JGMaXwZms8i83nnm2msMhG
         qxuIapSALuC5I4z0EKwNizZvGG6PaVYwrsYFc03clQ+zaffY9Yi7+Rd9DeVq8TqQMsPo
         mOa9KjkQgAnBHYiQJzjduIMO8ab1In9zxpTDESz20wql691IHa3z4eYMgIiR+VfFmdpS
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055391; x=1793660191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=1n5zMvhlX0kbHiso9A43hHHQzQx1HfX5rn6rhFXq07BLCjlPxZISMC9U0GLknizQk+
         OeIxQlctumyLJeUEJJZqz7gKQza05K8MiMqTBArf5883oT7I2/Me2EkaPpRUKUM+aPH+
         edBdGnFgmNU3MUmOllrpDJqaKtwyTiw2nvpX4g9jaRLcSudEoG005ADEK5FF17n01hE0
         ttePOa1Ezy7eZCNFrAMeBbeDnazPq5VGFYqTgGH1IyCrCHxYW956vr2Easv3aMU4VAt7
         nSeUWbrWA2NcYhxmiljnsir05HCZkqWvP07i4hDVEPM6Sg/O1/o0NTHWcIBk9VQOuzsE
         OOhg==
X-Forwarded-Encrypted: i=1; AKwUvBxpGsgHLawl8Mfl/8RBm76CQgrZ3YONvR+ev8eDIoO+Cwm9w/ERsfhB+6ITVRTROlnguaA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCT2z1+Qq/1nc4kaJfk78udX5BHrqsiM4viGEnwKCgKbMXksBU
	bIOZRK0yVt5bJR8Ya2HqKnXUiXQHMFNY2sFZPowQAznI6JCAgGo7vQqVBwK1Rcuvw+UT8B3flLg
	Y91tsBhfTrPnhymz0jMu7fiDexhUlxtiScaIdHoyZ
X-Gm-Gg: AYBFou22tgHMbiU1cPX22ssIbDBqV25LoCmDbTnjNiJATlRUcYYBWkH4z7x0LlGU1wn
	8FlqbFoigfyMtsHZmsbPpVsJp3+Bn/YOfJi754379RXghGoiS86Fq12ZSFi8tXmWgIB2SZz82rz
	IhQxg/3sQOKR/DYx1xF7ecgtGqEIXSlBCSd1j41uEnGgLdKVq2eftQgNaI2mdvMwEhWekuABZmF
	ewwxgc5VQepGQk+M4LYYH/xwBj+w8ugvanXjtu2NKb7wtZTxmnyV7rYZy0iExEWJlVwn6Rxbfvp
	M274EEOpqMrNZrvZoE/IhySAMdTnqh+P+PBmxAyKpA9qJFkcAgpNcm3DmnqKFeoGhvxKPD0d3KA
	r3SehIvRB+2YMUMg2MXIWuk4XHkR6IIUhOLLc6tWxtkY/alSbn8UXjCjNarDA5BRyN4cAmfwATN
	P2Qg7X8m0/YcXJWOrg6HYLd8vK98BvOuDeouIQnuJBJkLOm+e1Xggo0qcS6MAApkEyzmtdAsNiR
	AW2QFoY
X-Received: by 2002:a17:906:9c8a:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c46bde874d7mr911731866b.38.1793055390933; Mon, 26 Oct 2026
 15:56:30 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-5-jthoughton@google.com> <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
In-Reply-To: <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:55:53 -0700
X-Gm-Features: AclHuK_4pEIR4EnpfJkK690R4CHqdS4wt-7zneGKcf5MW03i114xuH5q5kcZiJk
Message-ID: <CADrL8HXeYRC8w7F7e_6ZXK6MHd6FRepN_zD632j0JPjNUDrLZw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack without
 an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > stacktrace: Don't unwind the user stack without an mm
>
> TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
> 7e8e6816c649, which dropped the !current->mm check, looks like the real
> culprit rather than 214d8ca6ee85.
>
> > stacktrace: Don't unwind the user stack without an mm
> >
> > stack_trace_save_user() only refuses to unwind the user stack of tasks
> > with PF_KTHREAD set. That doesn't cover all tasks without an mm:
> >  - A user task that has already gone through exit_mm(), e.g. when an
> >    event fires from exit_files(), exit_task_work() or the final context
> >    switch in do_exit().
> >  - PID 1 before it execs init, and usermode helper children before they
> >    exec, which are created with user_mode_thread() and don't have
> >    PF_KTHREAD set. E.g. booting with trace_options=3Duserstacktrace and
> >    an event enabled with trace_event=3D unwinds PID 1's "user stack"
> >    during initcalls.
> > With the ftrace userstacktrace option enabled, the architecture
> > unwinders then read the user stack without an mm. That access does not
> > reliably fail: the user half of the address space belongs to whatever
> > mm happens to be lazily loaded, if any, so the unwinder may read
> > another task's memory.
> > Use is_user_task() instead, which also checks current->mm, as perf
> > already does for the same reason since commit 76ed27608f7d ("perf:
> > sched: Fix perf crash with new is_user_task() helper"). This also stops
> > unwinding the user stack of PF_USER_WORKER threads, which never run in
> > user space, matching perf.
> > Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Is the Fixes: tag pointing at the right commit?
>
> When 214d8ca6ee85 added the ARCH_STACKWALK version of
> stack_trace_save_user(), it guarded the unwind with:
>
>         /* Trace user stack if not a kernel thread */
>         if (!current->mm)
>                 return 0;
>
> That check already covers both cases described above (a task past exit_mm=
(),
> and PID 1 or usermode helpers before exec, which have mm =3D=3D NULL).
>
> The check was replaced by commit 7e8e6816c649 ("stacktrace: Use PF_KTHREA=
D to
> check for kernel threads"), which switched it to:
>
>         if (current->flags & PF_KTHREAD)
>                 return 0;
>
> That dropped the no-mm protection, which looks like what this patch resto=
res
> via is_user_task().
>
> Should this be:
>
>   Fixes: 7e8e6816c649 ("stacktrace: Use PF_KTHREAD to check for kernel th=
reads")

Thank you, yes that appears to be correct. Updated in v2.
