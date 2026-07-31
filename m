Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9C3D9026
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510406; cv=pass; b=sc27sziTa6fnxgVJujI6/oDXT8oJLd1w6QW+SXqkCc59rlkCo5r3DqoFmGyyWKlxdzjnJIconOhOyLuXQzSlqJQqPJ4wQLti1xCuqykQu3DiMr3lVGzLpBE0SR4HVawKj+KmNsfc4zS2QRbcrZHGFACLe8tAN+aapsVxdH/24TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510406; c=relaxed/simple;
	bh=xnyDfe42fl4VXPovO3Edg4ZjeBg/Mf7ckMaqZIlKyMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHoR6H+9wctWM9V7wWZrmJioKMubkIvcyN9iSMRpsZOMfK87MVNy6odPuoC/fu5og97kTZbeXUo09lBqfDw3lJYCrIKk/KfqYUaNyIlLBzQmYBH4ie0ZRirze/NBc4Pm0dG0D48spx/NqvP3fiuFxKLpleJrwdS6XdSr/WPbY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g82k+h+G; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g82k+h+G"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c01c79467so313491cf.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785510404; cv=none;
        d=google.com; s=arc-20260327;
        b=BxYiPCMgONDtPnz3D1vEcK2GRvqgVzpLofWa/kVB64fAJjCdMe3qDPPbxlGapJZY1v
         7Smh0LH+XC44HPE6h/+9BzY0iz1OMs4E+s+yVFUYdGe1srQGgEBRRHXN6iVKhoOzBdna
         j482rM7SEfkiAuSFMfJYclS78anFY+d9bQ8wHCnCuT6iWg+l3K2D4s8JcYFsW/KtqswO
         yX9bk7YDMj/hl0M808iIw8wXnxkEmaaBuP6t+rcMlEXz088plDExvTzeirOLor2lxlhm
         KdZEKAqMvvL+T3aB+/KlCWmze01MwWL1QRbNUkXOIN3/6Uhi6/+qgOVd6d+mFnJ6lUnq
         tX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=njbT0j8N1fuPfd/jflor+N5hUYESmMdTNdxoSB//RQU=;
        fh=m3bqy6UIDoWB5gz4Lb6f+xsAl5/VRRvuAVXH1NE8nTE=;
        b=jnX8H7p4wI+eIclK5Ch18zXp1t9tweoM28ZoIxZgQFwShiUKb6YA8DLwQWzRsUUPxM
         /+LN5Xn3MpGW90zDypEFSZ6pYOgXYci8gMt3LkT18kGBerF+uzqteSwr837jYqBf8e9v
         TwOdtWYxdENdC6MW7LvYgnbdedRjFnbNk5l0afFAvu1t58lXyeliPt8bOGEG4yL02G4d
         adG5KzdxxhFGUBFaCZ3RCX73XfwA8t3rOFsDjTAcJC7F4g7yQSbfoKex5t+ONXD+luRB
         93PtrGHjjt6zBuD6qLMBlyW/N6rxS1VMapw3DoVvwkMdiF3K1X0b1nVXuwyRUIMlKyPq
         hkkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785510404; x=1786115204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=njbT0j8N1fuPfd/jflor+N5hUYESmMdTNdxoSB//RQU=;
        b=g82k+h+Gnt5KslwZyOUJBISvetEgp/MkU6OoOdLDtBEcSZytzJesEDzzwld9dMtnCs
         U5bGyoDAhfKDMb4WueecEczJCgm+tzWi34c+Qc3lh+dgyM7H7SFgLrnS+M8XHDFEHfpY
         sG9wB41ha1SY/rfUhN8g+yL2qsfI3FoOusAzjjOypPOpMwJ7y5n9xwGbrAKn30nyb2tw
         gVAIXy9D8GHQdEoBhpLcPByihJoTT0Nva0r3QyawrvDp2NBccHdpU470OVyb3W6yFmNH
         viur0DKjPpDKP4CaS+nfVHUwB1XouJWkzkBx8PaVZRIFrjkB+qs6lU3Ci6y/V4wMVlFa
         T/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510404; x=1786115204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njbT0j8N1fuPfd/jflor+N5hUYESmMdTNdxoSB//RQU=;
        b=s7cEXrs/qHl8sRybwcTVrNYpl4cK2R1YktxoE6ZkQKLkWdtcy3EJKXKOwVUQ9cihur
         d/1z00ddXuHlohsZczWEdW7qM5BktYwHZnBPQLx1AE9FXj772JdGbhBNDXZAHrYkuIwQ
         LQmkDEadLruipFR7czhhEg8hRemExdrnBNdq0CatnXnjSl/J725b/kSdWhySvz48vn6f
         17UyApmI/oBdJyE1efdx5C+hnzAn4mSErJcpG7hFBfk+dJnAnR1Mh6XcyNErjGWsWBK0
         qiRlZUF9PDrlf5F+jADALmwy8CBt662jV2MrnQC+QtefVeIDfLUR67s5zgUSiLIfb1M0
         3lTw==
X-Gm-Message-State: AOJu0YzkW+VW/PXxTlBen4yDSWaW19V2XNErjfkfc49O5W1PacyAy8Vz
	Mb+Xo3k15fNMWiLdXSxlrlx9MDC+ecK7xUCXqseFYAWLQrYNcpvKagy3OESCcXU2GmIMIg9vv65
	kQ564ww3+i497ljpXMtZeit1yk3xKExAbaoTveDAb9eeWNRtbTKGFCBHIqvI=
X-Gm-Gg: AR+sD12fQ5OC8N1rmJNz+IdDKOWmIc5QSHT7kVrNmEPxVmi+RqG80ApCd/5fwBNc9gw
	WIN8MgOVlN0KbVYJRgEyzGvevxQlZ+irp1bqg34k8b9Z6MkB/7ucX91K3AYKNys+8KLcDaWvcwj
	bMBJ+8KIkwwWeVO6BbES4NU0FcYgapTsFMyFV/yL1m1Q9D4ACCLxJWkilEIZmoDuhJaU1yjdX1i
	znOBHLtlChxA8lnyAHiMZQNOpp1FrLmeReqssN3oiS39IuH0ri/wB9nwKtfns9LBE7kooFzvTmV
	FApWELoiArcoT5fVbAbI2HIohmchJkBnVuidDmydD7nE
X-Received: by 2002:a05:622a:834a:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52b4aec7882mr10861661cf.3.1785510398815; Fri, 31 Jul 2026
 08:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714210303.3967981-1-aaronlewis@google.com>
 <20260715181133.GE3775915@nvidia.com> <CAAAPnDHkJabsf7haMLX7bp30qxcbXc_81y8mw5t-3bNWdm4LmQ@mail.gmail.com>
 <20260716132019.GM3775915@nvidia.com>
In-Reply-To: <20260716132019.GM3775915@nvidia.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Fri, 31 Jul 2026 08:06:26 -0700
X-Gm-Features: AUfX_mxkxE9kXc7gaLXdrdOqkJgZkSvuGAc-C20mX9Q1WYwcqg8jAzIlmPpw-xk
Message-ID: <CAAAPnDFY82jgEpjw_R7tZ8m6y1XdBZZOOkT=6B+yytyYsYZL=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfio/iommufd: Prevent scheduler warnings when
 unmapping large regions
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 6:20=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jul 15, 2026 at 03:07:42PM -0700, Aaron Lewis wrote:
> > On Wed, Jul 15, 2026 at 11:11=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > > On Tue, Jul 14, 2026 at 09:03:01PM +0000, Aaron Lewis wrote:
> > > > Both the Type1 IOMMU and IOMMUFD can be guilty of not playing nice =
with
> > > > the scheduler during DMA unmapping on large regions (e.g., 256GB). =
Add
> > > > rate-limited calls to cond_resched() to ensure this doesn't happen.
> > > >
> > > > This series was tested using the selftest proposed here:
> > > >  - https://lore.kernel.org/kvm/20260701203311.326798-1-aaronlewis@g=
oogle.com/
> > > >
> > > > And profiled using the bpftrace tooling proposed here:
> > > >  - https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@=
google.com/
> > >
> > > Given this is the same issue on both in the some place, I wonder if i=
t
> > > is better to try to get this series done:
> > >
> > > https://lore.kernel.org/linux-iommu/20260603151804.1963871-1-guanghui=
feng@linux.alibaba.com/
> > >
> > > And put the cond sched inside the iova_to_phys_length() ?
> > >
> > > It would be fine to do things in steps, like add the
> > > iova_to_phys_length() that just does the loops iommufd and vfio have
> > > today with the additional cond sched inside which isn't such a big
> > > task.
> > >
> > > Jason
> >
> > Ah, I think that is really what I wanted, but I proposed a solution to
> > get feedback quicker.  I'll wait for that series to be merged and
> > reaccess if a cond_resched() is still needed.  I'll follow up here
> > once I've had a chance to run these tests again with it included.
>
> It seems kind of stalled, so IDK if you want to propose just a bit of
> it that would be fine too
>
> Jason

Any idea what a minimum proposal would look like?  Looking at the
series it all looks pretty relevant given the goal would be to have
iova_to_phys_length() land.

Aaron
