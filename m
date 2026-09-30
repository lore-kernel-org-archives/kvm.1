Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6724B828D
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766125; cv=pass; b=cRi2aktrqIjQWFLPR/mc4Y4pdUmAGGMlb+3AV/aWXYBZNDOAPC8UGoS1EmOUgMDasjCbQ4h0m52NW5UpOHyanxy1++fAQXigfIpR+oMHPBkuU3WQV62wN0nwV9y5o3RKgKeJm8N7uLqIKFDgMcw09hEUmvf6lzWCq53MxGkHUJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766125; c=relaxed/simple;
	bh=Wn3tCGPYKvL/ZOB5BVe+yvOS9MKXjB6jsJiC136C6AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWxP3XG1QEA+l8suJisBilFA2Af3T3GQC64dEW7W4RjS8wmjaJIfUxAMKl00fUxFtspH/KrbSOChlhHmXsAcJ5qQdr1B5M5UDAsgdlz5bzYAe2mc3IVH9ufh9Pp/TwxGVpCbxQzdmnF9O7y8rd0O2/ceDQCL84fdhzafTVTXiyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atyNziQZ; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atyNziQZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e2e4ef20beso18185ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 04:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790766116; cv=none;
        d=google.com; s=arc-20260327;
        b=IQdik6ykJY6mum1ouUYmMN8sRNlGBOFQtjsyKGCkQsOAztM44G5YA1x1EA1yIqZhIW
         FELw7tdTG1DB9ejyFN4SwbR/W78fQRjPR5DRC/QtiEjQCarA1g6EKLT9nu0Fg4/r3RtL
         icn0dDFSzOroXiZPsLdGGnnYF8MTI5olaIqbPVF+rDof4C0RJXmLWsqPaOkjgr9h9jEy
         J+gK+w4i4Fg7mZ4J9JAhqdeKXJYmGnRtSpE1Cg1I81mJhTS4XwljoAKTkNCryZRdTiXX
         pN85Mm8Mllh2Sj5ry2z3uq2/UP4CFdHjHeWSXZMSlnUDkXoxcQqru9wJbOg+DaLGI6vX
         Tznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQ6Sc+nIdBskUWJpt20A28izei+92PV5/80vRS67SI0=;
        fh=o/fTGKQVzXB1VTbbS7UWq6eDjGMZjIKPWmO9paVPZzc=;
        b=MLd3/6rhrTMk2z1QZLVhSNRnadZsDaxZYzyoGLNuIzaR/LFdBHuKbVbI9rkktDm1Ku
         94Iw55uun+j1KjYtERGb2UClMvd2gC48v9v+BynipEnIBqCTjj5anx1Utk2Drw4wZBZP
         M7Xfm+/WyRQGg1Nt+Q3oHa9G2c8l80gFMQP77Pab2yr/DCwsus25Px1dcJSOzGdHWcUJ
         mX8VkSR8RuwP5drZizJkaWC2yvOJsadl8Ba2DR3fUF723hdwEtAA1vzz1+3uLHKQoj9e
         rpTgLIKhccxkcDdOUStUYIV0cE2/CoOApFEO7WJD9nteezU86QgoDUKb50WGFy05SdOn
         OHHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790766116; x=1791370916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZQ6Sc+nIdBskUWJpt20A28izei+92PV5/80vRS67SI0=;
        b=atyNziQZEeTxEc43NMDlV9JFYHvT5bv/NfqqKty+zU1LwBClXXDeyF7OtX67+0aCu5
         dhf1CYF28/79y7Dr30cPs4IssV5pzabSZnTHhp8KMjs8ocLnrXTzYPhTXlxHXYb1/JSV
         NxMoUos8WzhQYTSuo/Z+VSW6uWzCf4APO10W//yDw7sT/xR4uCqsTFlx3de8tLdiL/mX
         6lwj7dpWYEToFDGipmCa5IPkSC7u7HbRCabCPieqKebkKDn2qXEFSn4QLygQ1CiSQ0s4
         qFgn1myRmVEBSLsUcUhRcFo2IxDjNHE2e6HpRtdV0ZMdBDOGJFLbDA4mfywzdNT80RIB
         Tpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766116; x=1791370916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQ6Sc+nIdBskUWJpt20A28izei+92PV5/80vRS67SI0=;
        b=v5YuLfQbQlq9XyM2WYkHcNeAxkKkU9UijxpRtA7XfsedhT+mOWKbr3qFamPIJvNsul
         zdi+pQISCwaubxQ1Fn47UrUXF0WeebQEaQdaWIa5KJVKIyFczYEOg0rYm/18eblIN42W
         +aZbF4/OzcDgW9D/DbyILxK7tpbTu7XhHfK8ukBTIdZbybrPj77fJLGrv68FLBz4IF9U
         I2+EAT4wmCCtMWEU6gFTEaPbQ3bXrjLFvCdqjxQtnrB8MYhJxiju6jpXFHjZQh1lZcR6
         mX8z5uI6ntd7XF6Eefk9J3yl/q/q4r+M3s6w0sKOsQJ4foQ4OE/4i9h3nZipwR9d33m8
         htyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF5cRiESi9rup9fVQcEWeb//LcBarVx97oyyj0E15DLjvWuZaLE1moHAqWgGBcdwl5Id8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBfZ14WtaLr9ztC+fq6wJNM0QxNnpw1LC5jV9x7JreC8Xj/rQR
	tmLgGhG7EMb+Cz1YjFWIisXzK/JT6wRVQWxebZ6o3ks+5h81taQAYcv8UDQTzt+Bo1xpdmGMZYR
	WpAVUrZzWvacMvaEFeB4HljT8U0ZHFQhgwdrMLXF+LfIJSa+niYLD9o0z
X-Gm-Gg: AYBFou2n6+/cE0JNcP8QOzTNUbyY4mjfCvgErmslWuIAfy6UyQX/bb+kG9SWbdqLRbf
	phzT96R7MbhExVhE6PrkB0XOHWXPhO5Fzm07OZ3PxPuNS2DZknsi/blm9Ct2Z9s9Tov0rTB4A8J
	0rxnZylTrF2Fs00WC360rcdgYdWvlOyZFKxf8efyK61zGeKpXjhrHjSAZg4LkV5hJ7U82PGhbe1
	qQaQzq1fMXkHWoB00e9C+oSwSBbx6jddRqeIiOsKtCHtcAlyUc4fUJR+LiFGCCVNQbNtITG538A
	S+8x8h372l+Y6Ol1JiDpCBplxhR8qNeYi2G4qOUx/Ggz+bGY6z95YEE2D7EWNgTNSsNAej9u7pa
	vuHCiTkpz8a1VV2LvbA5Ir6WlsOpkEjiSY7GRb9jY4PDhQnVy6cSO
X-Received: by 2002:a17:903:2983:b0:2d3:153d:acae with SMTP id
 d9443c01a7336-2e2dc66931emr4275215ad.0.1790766115044; Wed, 30 Sep 2026
 04:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com> <ann8aPLSgLzz_6L_@google.com>
In-Reply-To: <ann8aPLSgLzz_6L_@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 30 Sep 2026 13:01:16 +0200
X-Gm-Features: AclHuK9FmeMYO8yhU3NfYnwkiXvx1GxFB7BRt8bYYt-pk5cFlRrTKYGllQj5ghw
Message-ID: <CAG48ez0zfaEgWoFiLyVLu_ZU8XtJoKVoyMrnxMcLX6e+3j0jgw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Fix page dirtying in sev_gmem_post_populate()
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 6:29=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> On Mon, Aug 10, 2026, Jann Horn wrote:
> > set_page_dirty() requires that the caller holds some kind of lock to
> > ensure that the page's mapping does not concurrently go away.
> > That is not the case for a random page we got from get_user_pages_fast(=
),
> > so use set_page_dirty_lock().
>
> FWIW, I verified that __kvm_gmem_populate() unlocks the destination folio=
 before
> post_populate(), so we shouldn't run into deadlock when in-place conversi=
on comes
> along and userspace does something odd.
>
> > Fixes: 97cd21d57e9b ("KVM: SEV: Mark source page dirty when writing bac=
k CPUID data on failure")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Note that I have only convinced myself that this is a UAF bug by readin=
g
> > the source code, and I have only compile-tested this patch; I do not
> > have SEV-SNP hardware to actually test this.
> >
> > This bug was introduced in v7.2-rc1, so if we can get the fix in before
> > the 7.2 release, this won't require a stable backport.
>
> Ya, that would be lovely.  Paolo?

Ping?
I still don't see this in mainline or in next.
