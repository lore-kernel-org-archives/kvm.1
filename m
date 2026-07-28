Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AA4746C0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279583; cv=none; b=ORQF8RP0WScuMBsp/NWRri/9DP7VEkDysJoDkVSkteopXVAoQunkrz8fPo4933TmEFLHat44XIMIWR3diTuVVVOwJ5s0Rc7Ygc/DstlM9vgCQ3K08wTGIjxIYroVQvBkgHdDYuJM9L6KSKa3hW7ooFR00l4OUvamulcVyUO9ZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279583; c=relaxed/simple;
	bh=WdXcIMczcDRNI6LiAVIZUBxe+k0lENaof1A6LN4ltQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kXKmHjmrgZMDmYoj58jsodT1qda2hjFEBkXM8D14tPaUlRS2pIkhH5dKFL859hS4MyIhOckxjr7v56VrVaSyughT6qEaLX3Rsk24rRCDlKKE4T6UO6Rq+b6AP8B48lEeyQ+9IAGMTzh1KG7ULV88x+1EHGBaQcDuo9g/kf/NmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2+T05pe; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2+T05pe"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e04598adeso252242b3a.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785279581; x=1785884381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=thdOOm/K4pddHQDmKddowM1+LABgvbQslWGfyXrJceQ=;
        b=C2+T05pe99SZHbMfqRTV2VNXTg75Inxq5sKLzvKbSlmyh2vk6FVtFOJJbegjXhUn6x
         1CEtFionxGA7YmsClZwyl86sUrNAWWrDPe/KlbTRyF6B+yvJaQ/nh/0eQ3+v/xbIlmUh
         1FkBf+eterU2rJX0Ap0d0xXMVmzndz9v6DQwtvklXytFeXKlGJ77i9FYB4Dswtr9KuE9
         RF3fEtqyFek1JAUCdNJwbsRC5P8Oy6XGrkRoYFsbYt3QEuNnoYVzde+th28yzIhYIusV
         E0QWGES+Hu8rjat6cJ438Eg/xDTQqfyDpPKLETyuxzbLbQip1hiLOakbEGLmqt7y8QFy
         ZHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279581; x=1785884381;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thdOOm/K4pddHQDmKddowM1+LABgvbQslWGfyXrJceQ=;
        b=jQGyBaS73V05i0C6Swm8PgIG9hiYddUSl5i34dNs5H7PYnWalyXLsI1LFseOvW/Se5
         3tLF7sTfGw993f9axQbHGZXqUObHZV+hJUIYJjOH3LjbTJqlhfCFaD7HsEKJ00o9ziTB
         TW4oXhklSuhWKfEjB/ZWGX0B4HPDHidSv9/jt6clxjJbzTrWkl0KYGrU8rkoudcUPNCE
         qwxqSO/Sv+TfkbmL6/o+PraxPNhuN0NGj+NGQ3Lozq+X7OKUhBSu9+ofKYRIdkSMM/Md
         WLFfMCfSfLeGVvENil2rXCBnLPIW3LwGYwYCU5LR46P5P6cp69KUigWKl4fUug1jtIp6
         FWQA==
X-Forwarded-Encrypted: i=1; AHgh+RoK0T9+eJHZ9t35KH9dc8puOrNWIWtinLoq8/EbGJo+pSzbGDQ4NRdMfa/CG0Lj9i/Co1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWqE7sfdp1Btdy+jtjUD1g7yhq1ACe4famZIJSh8TOfFewhcb
	dJl7jGJP0gTdoi5pRceTLVync8SOM2Xy0++AOCFKwKRm5MZwvstuguYrhwl6bcHdtwr6h3sOZIB
	hwidhPQ==
X-Received: from pgbl4.prod.google.com ([2002:a63:5704:0:b0:c99:5634:7551])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac89:b0:848:2eac:bfb2
 with SMTP id d2e1a72fcca58-84e93107604mr4560309b3a.13.1785279580732; Tue, 28
 Jul 2026 15:59:40 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:59:40 -0700
In-Reply-To: <20260728152156.A48831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-25-dwmw2@infradead.org>
 <20260728152156.A48831F000E9@smtp.kernel.org>
Message-ID: <amk0XODzenVy3D1g@google.com>
Subject: Re: [PATCH v7 24/36] KVM: x86: Use ktime_get_snapshot_id() for master clock
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issu=
e(s) to consider:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 57494812cc839..45a768fd7cb35 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
>=20
> [ ... ]
>=20
> > @@ -1580,14 +1581,39 @@ static int do_realtime(struct timespec64 *ts, u=
64 *tsc_timestamp)
>=20
> [Severity: Low]
> The commit message mentions replacing do_kvmclock_base, do_monotonic,=20
> do_realtime, and vgettsc. Were these functions meant to be removed in thi=
s=20
> patch? Leaving them defined as static helper functions without any caller=
s=20
> will break builds compiled with -Werror=3Dunused-function.

Sashiko's "low" is my "high" :-)

arch/x86/kvm/x86.c:1575:12: error: =E2=80=98do_realtime=E2=80=99 defined bu=
t not used [-Werror=3Dunused-function]
 1575 | static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
      |            ^~~~~~~~~~~
arch/x86/kvm/x86.c:1556:12: error: =E2=80=98do_monotonic=E2=80=99 defined b=
ut not used [-Werror=3Dunused-function]
 1556 | static int do_monotonic(s64 *t, u64 *tsc_timestamp)
      |            ^~~~~~~~~~~~
arch/x86/kvm/x86.c:1533:12: error: =E2=80=98do_kvmclock_base=E2=80=99 defin=
ed but not used [-Werror=3Dunused-function]
 1533 | static int do_kvmclock_base(s64 *t, u64 *tsc_timestamp)
      |            ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
