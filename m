Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A1224AF2
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146657; cv=pass; b=IApDhh3kj3DcdrqBakaYjZG0pjwi6LK1RNU4fA3ipb9PE1JmRMjMe0l2Ur3P+ZyOh8QEZ5cxSmWWgCBkTdZ16DPdpNaYkP66gb/+EAvv53UknxLU/zjbKE833vcDTtW6POVVy66gDIsVLh3MVFfu/uT3dhilfkUrQ8f/jjHjr2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146657; c=relaxed/simple;
	bh=iU1YwYoAygyp+BWavqNCzWfg8rVaP8+rXNT5jlSkSTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R20OdsMf8vjeHXIq3DhDq5uaS0S2KVPCREiidMEb67S4/PRfWSEv1l1RK1+PPL0VxaRWRy/TsPsvw84Db7ZGIjsCni5fhtODjhW1qiWXl5RjhBNpE8jX97qd115GuAMakjHaS/UtIVekHO/XG+lst+YCyyrm6LY+292u4OP6Xjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwl/W51I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYDlFghC; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwl/W51I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYDlFghC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782146655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJK8pRhztD+ZfAGydDDkwNciqiBh2eBxW3tOhdwjnHw=;
	b=Rwl/W51IQ54xlxFV6lxhDM3BzR7uQgbalUm5Hwr+hKRfb7hIFNpR/8i/5wsbc+JsKke2nk
	otu9HHkG+sXpYFmnZgq4yaW60hC/Okhb4TDkXB9HIqBExyy5584n0fYZEAGlJAtKToWSSj
	WQjcGW+nHTGWA4rHwHcrGPTxhOLybyE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-iyFV7lWiNi6QS-W0qvm7hA-1; Mon, 22 Jun 2026 12:44:14 -0400
X-MC-Unique: iyFV7lWiNi6QS-W0qvm7hA-1
X-Mimecast-MFC-AGG-ID: iyFV7lWiNi6QS-W0qvm7hA_1782146653
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4923411f041so37142395e9.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 09:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782146653; cv=none;
        d=google.com; s=arc-20240605;
        b=kBlEyeXFiWeuu/xNpzs/ZNai4bYH/Ym7y0jb3XAxryGO7iMrlatoPopwuZjnyGTm0D
         s78TZqhvj1eWfX0ab1rNPHc4Gkh39nNH5xQj4GpVOuTsMe8xwIlrbl/JWVgVuZ/BR/qn
         1/o89Mb7vHoMZUuLachbJKIwS/EiEsrdIFx3CJGlyNc7C6nJqL0Ve2QYI89uOI6CtMl5
         e1bpFEZHch6covRdo9z9QXSouXpJRUk5thJRQo4aRKQyQS/omPxcR5u1xfUpLiW6b4To
         kIl4QuRIrhEoEhPutPXZ+eNiiDpsjXdcisNUNLAmJfp89K7Zyr0kAlT3EpuDNM//ve4U
         dooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJK8pRhztD+ZfAGydDDkwNciqiBh2eBxW3tOhdwjnHw=;
        fh=vpKy9pEaTqRr8JgC0a77xBrE8v9lJJPHqUh7xrpbej0=;
        b=NNXCfp1YG2arvGEk5kUqcztsCLE3z0i3HWwTEhYwnRZGzC3WA3bg6TCoOr/WZgvzEk
         k4Qo7gt6a78gODFrjbugIpT2BkkJb0uDIGDsXi9miaK9vkg0iZ5OYopDhra7nD2ysVl/
         0Wdo54U+75Y6O1EYehDepIzAvupwsRIfGEIzgfX2U4qBQ4bZ0LAtDRTOeJo30Qx9UYa6
         K00a/8dnV7O5H6kO1zk9gRaBUyoD7BXc8f06+k7aLrlm2QFNovkpwWQCK1NN1B+QRaCc
         v09OD8xpZPZRIkxJksD1Kl4TqODDQZNt3evx5QuAmR3t8q4DedZo1qNfzFL7XTuca0Le
         fB1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782146653; x=1782751453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJK8pRhztD+ZfAGydDDkwNciqiBh2eBxW3tOhdwjnHw=;
        b=HYDlFghCwAex9DSOdglq46orwrryFwv+YHkPjLBdf1gVLqZdeOtkgxen2QGvrq/3xb
         zUtS+dY6saqwdrF9dKME/y497EifX3C3r0F9ZcaSwOZ0UXEQXv7cC1EPW3M9XJWarrxf
         74paAUDnvSs9KB/aWo2P2QL6dg35XyGyqMmWVR2Xt6Y5khocRzEhvByFz1lqrlso9oS2
         9bV5QP8Dk4HG8q4LlNVwHUb7Ntnk6ApjSweXfJo2F0FwdfSP+un+IWN0xtCDPWsmMOCW
         KTyGS+8wwAB1CzLVWl6mUSkrzUJ9Sk1UM4SKfYEO3BuGJ7uILLGfynGZQoxZC6ViJq1W
         xs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782146653; x=1782751453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJK8pRhztD+ZfAGydDDkwNciqiBh2eBxW3tOhdwjnHw=;
        b=glKe24PYTpHVr6QGLppqhlkm3eXU7V4//r7GeJBbQmTkuJcaxbVm2yrDZPPzJ0Vbhq
         InqgiVprxaMnwPPfGTH16cHQp1MUKtBUKsi40GCRgGGV1WAZH2W+shDScLgCtxqj4q4V
         G5cx0jl9jTtKXm9w6+2jBJMtD9SBPsydZ7xH+dqyKLELdaISQs2WXwUn9IoZPditnXZl
         LnVy3Er5reThQUr+szhAV9waeGVZyuABb82hXGH7ZziEIY0moN6vweUpjwLWX4sA5I7b
         O5bDBSeJtrX0D4ol7P8Sdyc3qj14j7B0DLK3u0DjVTFMOJtAiWVJCOT9a142DsXCWf8o
         VlKQ==
X-Gm-Message-State: AOJu0YyMqclUUNEVP1Xdd8/WkN8GoDaA1QDIXFMUcZ4QnAMHwmXrjOGZ
	2ZwiJP8US9r/fi3aBvzb1qbVUPRCgDrypOFI5GDbqPV8k4XhUTT1GEOgHK9kpr3Gz5/djJNozco
	DslWaMRHC8c7f+etufbO0sQapv/w5xrZ9z62u96Eii7x4U6O/I5wTfVkzYBVlb+bWTYzwT3nqUd
	rJg/As5Loz/KyU/Y2K3zJaiwK5wyhB
X-Gm-Gg: AfdE7cmfaFxOlSPZuQavKYUhABRuyvqwh4Xwsi4hgIpDLvqnMOKluuCfIIRF6Be0uR8
	PX7Qr+ca3s0BZ9qGqG3SjCC6Cwckxmlk7Ql1Y0Q+ao4YfmoVtsk+iBUXFH+uClBtrZiDDZdxFjf
	AXc15IcDTloOor/SduZefUWyWqLDfTSMXgLUJWdj3OBBsZtoSGH1jM1yPuNkqtEtKYD7RBFTpRT
	1NvpDP+Ma6BuvWqvtO3LuKZISZ4KL9Qqo0pIoJgOVwRe0FpwYhRLgw13zHe6Oz5zcMO5Mop
X-Received: by 2002:a05:600c:3b26:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-4923ef5b897mr312230225e9.10.1782146652925;
        Mon, 22 Jun 2026 09:44:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3b26:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4923ef5b897mr312229855e9.10.1782146652611; Mon, 22 Jun 2026
 09:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622164109.26350-1-andrew.jones@linux.dev>
In-Reply-To: <20260622164109.26350-1-andrew.jones@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Jun 2026 18:43:45 +0200
X-Gm-Features: AVVi8CePRzJXcD6LR5j6y6WyE7vc7SixuaQjINEUFdCP5FUHJcPaBosPx5iNd1A
Message-ID: <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by tag
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 6:41=E2=80=AFPM Andrew Jones <andrew.jones@linux.de=
v> wrote:
>
> Import Linux commit d1db4118489f ("checkpatch: add support for
> Assisted-by tag").
>
> (I should have used AI for this, since it'd be fun to include that
> tag on this tag-enabling patch, but sometimes I still do my own
> homework!)

Personally, I don't see the point in providing free advertising to AI
companies, so if I had to choose I would do "WARN(...) if ($sign_off
=3D~ /^Assisted-by:/i)". It's more important to know what AI was used
*for*, than what AI was used period.

But I won't complain if people want this patch.

Paolo

>
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
>  scripts/checkpatch.pl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e858261c95a8..653bec1f6ea5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -626,6 +626,7 @@ our $signature_tags =3D qr{(?xi:
>         Reviewed-by:|
>         Reported-by:|
>         Suggested-by:|
> +       Assisted-by:|
>         To:|
>         Cc:
>  )};
> @@ -3073,6 +3074,15 @@ sub process {
>                                 }
>                         }
>
> +                       # Assisted-by uses AGENT_NAME:MODEL_VERSION forma=
t, not email
> +                       if ($sign_off =3D~ /^Assisted-by:/i) {
> +                               if ($email !~ /^\S+:\S+/) {
> +                                       WARN("BAD_SIGN_OFF",
> +                                            "Assisted-by expects 'AGENT_=
NAME:MODEL_VERSION [TOOL1] [TOOL2]' format\n" . $herecurr);
> +                               }
> +                               next;
> +                       }
> +
>                         my ($email_name, $name_comment, $email_address, $=
comment) =3D parse_email($email);
>                         my $suggested_email =3D format_email(($email_name=
, $name_comment, $email_address, $comment));
>                         if ($suggested_email eq "") {
> --
> 2.43.0
>

