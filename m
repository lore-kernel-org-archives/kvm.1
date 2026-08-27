Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0427603A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838499; cv=none; b=Xhd1dWvNkKl1s8nvwBYg1g2B9TAAK4Qm2B8AybezmNufBA/jV9lsbr5O8qnyoRDzLQUPEUCZsaAxDOdNZFrVv0JwUSb/kzy/eVGLnghzypNe9qoRPnI2Jyg0KPFx6ancfl4xoJYWPId/nZx7Ft04NDk2pjf2HQ8x4PNuGqupp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838499; c=relaxed/simple;
	bh=xXafbhcFPPSSpbzTZbsGVk1pCy0s7pK8aW5HRziv4MM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=amOh5CzzeLeL1vqvegzrrjoCD0593Cc90agx/asNLg8netixC6hgVIOHPeUkUjKgPLOtTLbiYglQbdo9TJztKHqfvcLkz3OMVwvsfxBdO2lEDJHb8mX5BoaEN1+Uq8LEcPTfQi4m/78W3xz1UGbeH1+TlBaHtXbtktcSAeGybuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJQDrDCb; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJQDrDCb"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc15155cde2so2687661a12.2
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787838498; x=1788443298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DusLiqhfhbPeCoA/ZnAQoMsY29GgMuSSwGngcrjqGF4=;
        b=WJQDrDCbit8alwevbA4+eAu+sGC7xLaLchNqZTaxlvllxabNYHo6PnMgW0kOLArHnG
         spoeVjdqWU07aIK0s6vIjETshWvJi2Hk/0h3YXcDR4/0fY+UB6KWDyxbTROD53OqtX3k
         mTdyIjQG3EpYifDfh0G2ALDO+jo31NR/4CFDc2LXHBcuOP0ImdCnfRNYStfPStLCa5mO
         50kV+atEEGbkDcsEyQS2i4A2mdICP03mxF2oztv6YVQa+DszNIdJ1L5l1U/K7QfyB8+Q
         RfFrvaQem5En+lio3lLZSp1uKw8un/piGdN883Gd/9NrB2iKnSGwn5LXT47MgeC5R+6d
         1aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838498; x=1788443298;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DusLiqhfhbPeCoA/ZnAQoMsY29GgMuSSwGngcrjqGF4=;
        b=G/W+oQptXuqlFjId/vky4sUyILr0Ovgw1Nn9SX0DzvHOWkqgMLhHdZjKCd81v/iB1k
         ngruAMyoWzRLvGdrgjqSWKKZ11VfTcgRC/hD6TChzZMhtQcPYuTTlXsS//u/3XqC6Ub4
         0XNn6lPwgTsN6Wd3GPzFglFqbQ5lLloDEGUNW+WXn8dsIJAWKmifhAC7p+f2wyZeYbpR
         FbKoeBvX7S+Gqeq/7nn0ZCPSeHtGmwS2ymL3gPAlPiviOPTRoAuHgTmids7E824IlTFG
         9Z6h488RvGUANYTC/zbEhyVIsKxoZhMchDoOL8yQwl4qamIEedBM8CLI5dVQNBCjbMZ5
         XLsA==
X-Forwarded-Encrypted: i=1; AHgh+RoRQ67yyUuIfoCUQbvadzt1ggLxcJPKTrt6lJlLnep6XaXg3SPk990fLDNeLV+0q7otTnU=@vger.kernel.org
X-Gm-Message-State: AFuF++nZWizOyGawK+6csI1CBj80pXwv5Ouh8TE4O/Wl3FdhnTIIv3gl
	a6bMEb0FC/stWJYB/tBnPGv2r5Cv7SLdaYzM/weHqnDze9UkxnU5Rw/SqrJX8spTMffeqUCYZ8B
	cWAyaVA==
X-Received: from pgcp5.prod.google.com ([2002:a63:7405:0:b0:cc1:c65d:a776])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3117:b0:3bf:a543:e7f5
 with SMTP id adf61e73a8af0-3cf7586efb2mr34803020637.3.1787838497602; Thu, 27
 Aug 2026 06:48:17 -0700 (PDT)
Date: Thu, 27 Aug 2026 06:48:17 -0700
In-Reply-To: <CAO9r8zMA-E7UYzNDT=0rn7sv7+=Ydxy2zzikMPV1_YarH9sOeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-3-seanjc@google.com>
 <CAO9r8zMA-E7UYzNDT=0rn7sv7+=Ydxy2zzikMPV1_YarH9sOeg@mail.gmail.com>
Message-ID: <apBAIVaHkqI_H50o@google.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Bug the VM if KVM attempts to walk more
 levels than the MMU has
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Extend the "EFER.LMA && !CR4.PAE" check, which exists largely to guard
> > against KVM configuring a paging32 MMU with more than 2 levels of pagin=
g,
>=20
> Is there value in keeping the original check? I suppose yes as you
> said it exists "largely" for this, but it would probably be nice to
> spell it out (if we know).

Because LMA && !PAE is still an illegal combination.  The symptom we know a=
bout
is a misconfiguration of base.level vs. the paging template, but I also wan=
t to
guard against any other symptoms that stem from the bad state.
