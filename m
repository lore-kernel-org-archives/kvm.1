Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9221D596
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545592; cv=pass; b=KXI/bKEHLKt7/oH2cKhFRqClJDGRbHoEVbA3p0nE4vLQ/V05e3gmc3ParBEsEJtONLAh8+KWL5kQGGY7/Mr8d+tzmKXivrEzXrx2Dgq/wVQVnkjlr1VxhfXf4OE1Rk0MHjfiKNOyRNmyPcgjrR3vC4bw2VFnUQTQa1yiwsHz0+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545592; c=relaxed/simple;
	bh=isVfnTmC98sYuVeEgRoddardlsLWHehHpzCcEH2xTcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/JRij1S+iyl3vChd7GkK3XEHBO2ycvurnGAQJCXwB2Ck41pDx/P3Yi9B6icTaF32UQ21bsSJsLu7a06KsVXzC6ZDBjz3yiczL8RwVxzkRP+3jufGTXgHYKo4IWkHVkjzv4FgROv8gD/ZmKPGpIsM6wSNJAuwwjjpHzEwYorUGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ua5zSZDM; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua5zSZDM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51765531803so33631cf.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781545590; cv=none;
        d=google.com; s=arc-20240605;
        b=EYlOxgla7COUHYFnHy1UUVexdg395TfTVHoGsvVsN4IbsJdJ83GkzHA0NFr3kIQbEK
         4jBpQQFAACHdTe7AjEAjKF7yCDAI+Sxn6+4P/evf7daD1v1Ti8UUIBzfkrgSfw7eNRdr
         ch+j56Lbk5rClx5er9iKuhXVLIfb8Je9iEJRsr1u69fN7TuqLlllCr5Fptn3Ej1L/oSX
         SyhycIdla7EEj0JjDg8s6X8fk/3V4haqJ5pTXg3DOdevrwWZWkBnSG+oTmr8cWEg0YDG
         w+KCUrbTOGIeonXPNYwOCApVQ9uM8ClncPVNWzl/V6yUDsb5pvqjSR3jfrvWeg13ODah
         2V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=isVfnTmC98sYuVeEgRoddardlsLWHehHpzCcEH2xTcM=;
        fh=o5aZZT1BDiZPXGs3J1Qf7e8zSSpNs2bBh4CSu0cYRCs=;
        b=KZSpbye+RsAX6jgOmD7NP0UMlV1WObeDZvkGViSgQDMQHZOnVpZ3+zFwSWqQiJCAXx
         fUQR0JwcpIQSMMNk4xKtZvty0Z1FUwT0epLYLyGx12lVntx8lgcdCR22gcXffeu9Np0g
         1jtvhTx9z7HHN1pQfq4XuWckIvcTry1eRueN6x9Lb3f5cctTb8R+ZrmWqY5lTXWxCHng
         P8ix28gN1eCW4CRRUmctkXmCTisLA1VPX9+4UCQO8lnMThOyHzAwlvSgLKQvzTstPiV3
         DL86XPrjRnr4l1sTvCjnEQHEr8hZrLb0h5iV2l4bshd2idi5U0q83wYFsTxryedpiyNz
         ZWWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781545590; x=1782150390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isVfnTmC98sYuVeEgRoddardlsLWHehHpzCcEH2xTcM=;
        b=Ua5zSZDMidO7gAeVOAtwZlb5+cM/wnYa8tUDHOfLRPEfDda2YIUQudurms7/dDT1HN
         +BBcFucvxjaE1W0e4x1WvAONRHFOR3FaQ/GAOUkN7idZjJi82SJpnySxTlZupAY6ngZa
         HIrUGBYzAahTHyQsiZEXVjtqB3eJhXS0pUcrs16cLu50CQpr4RNW3GHHjsHe5KuqdQT2
         qB8RljHHToZpwcewib1XGBTPVvt15A2WLbFWnBu/fNeI8glzikJq+oLqm3i9aQQW5PYZ
         npXSbgTbU2vxOfYvkQJILdH4Xvl+86ulS/jetEvwEhbgy04gdvmGEXANbhBGwXQJ/Wyz
         rpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545590; x=1782150390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=isVfnTmC98sYuVeEgRoddardlsLWHehHpzCcEH2xTcM=;
        b=dXQOfkxYGQowcLCS5Ovc3ydDkqql1MTUZFy54pyA1Nrmid3lJHkBlJsR1umuMr5VVH
         k5nVOZDa80XJaVnbeRsV/RCkSo81BmDLywVoJT+UtEDaHG8OTFLfbTlXrxS8bGwZDJ5Y
         JOBNnFsIAtet2qehZna6qyhUSJC8cpaF5DoMymllbG1iEzMEQwymAc9cW4NpABKsB6Fc
         b18u7B6/nzkjWUBxbpm5A7BLsO+p50PmQIsQgcA3LyHwYlpQFcCLxCpYDS5Tq8tKEoQ4
         OUKUQg7RBEB6zCsak6LSGCGsNQ6NdMFYOr6qcfxnLCe998+VQ+TUDGmS2pIZVjdeJebo
         9Pxg==
X-Forwarded-Encrypted: i=1; AFNElJ8/tJieYF+NU+nOccbiz4WioES7izoXtj4lg4PPP8D0RW5cl6wf38/Xsz6F1oOZo4mWHgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TOw/3AoRNflZvUce49y/H1D9+By/X4KMpBCRSOUPVTldQZR5
	JqHkDvu23IA74DaHcioUYQ8T0kdBQAs0U26IFRLN8i4w4c8zWRoWITg47+1zOTvt0S+KJJ4xMxf
	efmQbfLExuJnqbJjMwj2+pTVCgJfPVE6gCHDej3Bt
X-Gm-Gg: Acq92OH5mfnAg1FxK7xTT5PolnJq8aRowYoagTH0ZNvr88l8K6rPLcZzVx0J6m4saBw
	a0csuAxwCOau4q7KH0f2589V3mOutXYrN5XKO2+onUNqaYo+mkrTI7SN8AqaHpq3Kk/DE3MvKG6
	fZGdKV6L6sOMdLK5qefwPPVpGYDmPacavwpbWw6o0NWQuDnN3kzHo7ER5EHwNYD7Rs9QaCwP++Y
	U9dIg95q++q9/OJ3tZdOaZOO/PNe4DuRCHvGIkJnu9sulrkzZ77EqRZV2VrGneKOIB9bKq2tT6K
	wUioFgs=
X-Received: by 2002:a05:622a:1e89:b0:519:56a8:2693 with SMTP id
 d75a77b69052e-5199046f149mr501441cf.24.1781545589199; Mon, 15 Jun 2026
 10:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-2-seanjc@google.com>
In-Reply-To: <20260612230113.684301-2-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 10:46:14 -0700
X-Gm-Features: AVVi8CcpmU9YFasFyUBmo4OwTGFHZGO0qCKCyvTbRj5r9L4e0Qj16mXOZbxmxOQ
Message-ID: <CALMp9eTHNSn2t3pPr1qwEtJxL9mTE3pqoDCXec2_uNytpSyr+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] KVM: x86: Treat any non-zero return from set_dr()
 as a faulting condition
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:01=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> From: Carlos L=C3=B3pez <clopez@suse.de>
>
> When emulating a MOV to a debug register, em_dr_write() calls
> @ctxt->ops->set_dr(), which is forwarded to emulator_set_dr() and
> then kvm_set_dr(). The latter checks that the written value is valid,
> otherwise returning an error, in which case the emulator is supposed to
> inject a #GP fault into the guest.
>
> Commit 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr
> to callers") changed the contract of kvm_set_dr() (and thus
> emulator_set_dr()), returning 1 as an error instead of -1, but the
> caller in em_dr_write() was never updated, checking only if the returned
> value is negative. The end result is that em_dr_write() does not detect
> the error, so an invalid write does not generate a #GP, but at the same
> time the register value is not updated.
>
> The practical impact is limited, as check_dr_write() already checks DR6
> and DR7 manually. However, it misses DR4/DR5, which alias DR6/DR7 when
> CR4.DE=3D0.
>
> Fix the bug by treating any non-zero return from set_dr() as a reason to
> inject #GP.
>
> Note, the manual checks on DR6 and DR7 are flawed, as they incorrectly
> prioritize the #GP over a DR7.GD=3D1 #DB (the General Detect #DB has
> priority on both Intel and AMD).
>
> Note #2, relying on ->set_dr() to detect #GP is also flawed as all
> exceptions have higher priority than the instruction intercept on SVM,
> i.e. the manual checks need to be extended to DR4 and DR5 (after the
> priority bug is fixed).
>
> Fixes: 996ff5429e98 ("KVM: x86: move kvm_inject_gp up from kvm_set_dr to =
callers")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> Link: https://patch.msgid.link/20260601133320.91479-2-clopez@suse.de
> [sean: drop explicit "!=3D 0", massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
