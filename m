Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8803C81A9
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179437; cv=pass; b=BPbxrq4xz5CXp3hxLoMgwHJqO9iIiq3s90/y0OxpNMaI7DJYELaSkwR7HsFDH2mSMSd3sTquad5Wh+m6OJtgFMC0RTBckjBjzCkPekOX3kCjRxSBIHw56IVnMUUsD+Gml9Mt79qf8DpbuIyO1bhtlA1D4U61MGeMFO8/YU0JU1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179437; c=relaxed/simple;
	bh=T24EBAmmRXB3PyxMRw5x/uGX9vSuVj8AHohfJzGwWRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izWzzRKw7em+UwOHX7fRStTOL9+wyoZWwa2A9ZxewbqV13wl0X+rmn2eYzyXH9SMv9oR8xNylz1cu/vZLkzb+nOcrOg8R15pjwhLBe0s6oVJpEJF882R4ShQ5EjF9QDgxspK9rHNnKvOoFS2AUvgDJ4xnEn4QJiy/Q6Gd+MDvP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXnHxUpL; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXnHxUpL"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533202fe429so60011cf.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179434; cv=none;
        d=google.com; s=arc-20260327;
        b=YqoNpn5ZHTrSItYLCRhcctG21QVPPA/f50d7ROq4qU80FMzAXZ/B/RJGlt3PLZjYHv
         YK3SFnYF1112On+9jf91VpCwJs2G98IQgjV7AifuXRLbOmp/U37CfNe/SuxIQ9cn4F9r
         VwGWxUm81ZAm8+HsezgfU5cvIy9TgXTPZ9RpOnn/q5PVNKhERtO99UJLN6a3gctq8uFH
         2wMTyW7v8xLD8HfN78LP+ZbfCxhnnq/XE+KqbKcHVoLKkuFQzl1EVX4QSsWqnAQ5qScD
         Uu60QeQO7fl3Ri95q4nCm0MJJgBYzkV7/v6R6SPcY5da7C0qjQwB51eo5Csq+KxaQcET
         tMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Um6BosUUMDxetnqhnpCeanhIvXYZRN4p7ISZfy18W6o=;
        fh=rTJhLibnQWSAAftPIEdQxURNUuPmjdJJIXl3wZ+x5iI=;
        b=NiczJ2hakDcXiN3gI3MEICktV0MHc6VOrEFC/IE80ZU6IVP8EVykkOo5AuRA1dYNIy
         LTOhlVoo8CjzxQzKE3JMKdK69YucAC5S2tfq8mJk8Bdle4IOr2THEIjj5w9ZVRQm+Zh7
         u7z3UzlcTAXi7WLxXlhkGdpf31/Z4Ok1vYdo/69CS6UCWrsK9jzGGN9FGa/ZIt1Etoom
         U/dbX1CSRhrLxD8XquGgrl39ySstcXEQccbGAJDoPUY/ErjZj40fPyEryGIikk0XP1no
         FKGvFrE7ZihxyZWBZSD6g30nmmJMeE/ruwR6tQdl5VTkyFx5M7/DsZ+xURXQumQXGC+C
         zCDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792179434; x=1792784234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Um6BosUUMDxetnqhnpCeanhIvXYZRN4p7ISZfy18W6o=;
        b=NXnHxUpLf9ZHs2Q9xRKz2TCK3RLgb23vin75BINP5G0fCtS0JnsAGs9EjLbZDDKSZ5
         9nBtWIh1Mn06jqoZUfXHHhlBFyR/0AWCXJUJj4J798dmxlcsyjPP7OZkt2oW3vCwHz7A
         VgEbGEYbg9FfB2aHBBRxrUmbXFvKFl2DN32yuKBfGo4qsMyAGBmAhaOExxCai+bRGYgk
         ZcQyrrTnf1UxGpLKQMvnLeyZx1BBinid4w/KEym0q+qOcH1uevYFJlh90mkmXaqzhMkz
         Mmf9UOyaz0Jvh3FCLDe8DD6HQx2ufeD+MH+/at8nhPt7Tbk7YpjJ9fYCPLeNdWr4iLuM
         9bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179434; x=1792784234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Um6BosUUMDxetnqhnpCeanhIvXYZRN4p7ISZfy18W6o=;
        b=ISZKlOKKKrdPAIvjFyp7mASVWOHCECZbi+I5FT3osZzJs6K6QS7rA7hJEif3xa1pT8
         4W6VamMYl/EKA05WJTlMpCZNDj+4OK1YL/Kx7JxwOhQaFe7mV4RNQkmOAZ7skjywOQf5
         sWSZOG3RprG8vG3KdwytzL6N6LWOPBDVjhQepgvzmFQLt5QI+KxSCPRcAjcD40GIyXuD
         AERh18niQmz4EfOVtxHpv0l/dzlSxFTnsQ74UtBKWp0oQGZG2+jRKE6ZyZI7+T05moln
         bFPyQhzgRW7iifT1E2wmhXaElrhDFNz6EmbIp7noSn1ygIPGvflHW2QO2ojn/Rbf+1U4
         n8sQ==
X-Forwarded-Encrypted: i=1; AKwUvByIm1mcMbl6MOlFGYi59rZJi1GXUWtyNAJSfHOZEVsr/zemVfkpR451vIWRjlhNpSiASrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzG9OoONs2+RTSXXKwbAtuSe0xfC60Dtkmo/EgZgxNGdRKB0g6
	t07IfWOpOAIveoM2aSKMuFOFSIsY7+OfheWgOOBdPRFXwycFWaRVQeIePX3B+Ayf+OerknlaFDn
	wOOoy1ZrBfMBqUU/Lqtf2+sC0+kkeX+UlV0srpfIX
X-Gm-Gg: AYBFou2BkZiPJ8dU/YFeFMiMjO4/3EqUzVzAzTN9HYa7flkonqndOkgZWKMxOMJHedR
	ox16Uq/uKzTnC8S9E3YZBdzKzDiG4CA1tba5DVW3hzHnzC+2wqCosbRJa33d9SjA5KuQQFSZQrA
	kd/UvOmnCFYzuX4+TmP8ZNLa9+epyAiyIUUhM6g49nZNIJTuOEu2UfOuzkzmOTEiI/NUc0gpKOC
	r4rQkZPN5OYR5UDOLe5R12fbvlEV9VXvf4v9RvI/JNX069mVlzrb/GpDZ1hHqBFotN8x+Y8VRR/
	z1rN9FMZRfThxB5zTqTHI3+m+W308qSR1apJyID2gw0/cwB/HQWlxS9z
X-Received: by 2002:a05:622a:598f:b0:536:3d22:fb83 with SMTP id
 d75a77b69052e-536465eabddmr3092751cf.13.1792179433180; Fri, 16 Oct 2026
 12:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-12-yosry@kernel.org>
 <CALMp9eThakVB_zqPQX=fQLrKh13BR33jmGg__rncOLDa2ZkXWw@mail.gmail.com> <CAO9r8zPHA2Xbwqm5sL1uymCy+T65LKLWDh6CKvV83euHhxPWTg@mail.gmail.com>
In-Reply-To: <CAO9r8zPHA2Xbwqm5sL1uymCy+T65LKLWDh6CKvV83euHhxPWTg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:36:59 -0700
X-Gm-Features: AclHuK92jepxWuUtFmMlKXO_5v4ZdybtV_AOdjCsjdE0ksCnXN8ts3BnKwKo--A
Message-ID: <CALMp9eR7MLnZNWFgDWBuux6uuqWOwB0CrDs9UyYouSPHbZYbqg@mail.gmail.com>
Subject: Re: [PATCH v3 11/27] KVM: SVM: Only flush the fallback ASID when used
 by a different vCPU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:03=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Oct 15, 2026 at 2:44=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > Instead of always flushing the fallback ASID on every vCPU run, only
> > > flush it if the last vCPU that used it on the pCPU changes. This avoi=
ds
> > > constant TLB flushing on a vCPU using the fallback ASID if no other
> > > vCPUs that use the same ASID ran on the same pCPU.
> > >
> > > Note that checking (and flushing) the current ASID on vCPU load is no=
t
> > > sufficient, as it is possible that a vCPU is using the fallback ASID
> > > only for L1 or only for L2. To do this correctly on vCPU load, both L=
1
> > > and L2 ASIDs would need to be checked, and the respective VMCB would
> > > need to be flushed. This would not be much simpler, and would perform
> > > unnecessary flushes in some cases (e.g.  loading a vCPU that uses the
> > > fallback ASID for L2, but L2 doesn't actually run until the vCPU is
> > > unloaded).
> > >
> > > Another alternative is always flushing on vCPU load if the current AS=
ID
> > > is the fallback ASID, and flushing on nested transitions if the new A=
SID
> > > is the fallback ASID. Again, this is not much simpler and also incurs
> > > unnecessary flushes in some cases.
> > >
> > > Do the logical thing and track the vCPU using the fallback ASID inste=
ad.
> >
> > Wouldn't it be simpler to track the VMCB associated with the fallback
> > ASID on each pCPU? Then, you avoid any confusion regarding whether L1,
> > L2, or both have been assigned the fallback ASID.
>
> It would be if we went with checking the ASID on vCPU and nested
> transitions. But since we're checking in pre_svm_run(), I don't think
> it simplifies things. Oh, I guess it doesn't simplify this specific
> patch, but we don't need to check if both L1 and L2 use the fallback
> ASID on nested transitions.. but we have to check if they both use the
> same ASID anyway for SEV.
>
> OTOH, it would make cleanup more complicated, as we'd need to do it in
> both vCPU freeing and nested freeing.
>
> Did I miss something?

I trust your judgment.
