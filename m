Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C617D6
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792881; cv=none; b=MYsWhIT+11YVbB2Aldp5SS/7biLyp4QGMEU/XxDG9Yh3jBFJ4yeEtCCaUh7v08tQPQNsqbvx16WjHvrZeAv0VH9bTk9pf80z6tjUrHug3ItFovrYp1ty7kJSwhQrozZXMOQyMVWeTodpIX5cshx2h3xHm1kHQsKMHFInUTu/2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792881; c=relaxed/simple;
	bh=XqKubzGYoCaN00MFXoG9fIkhNKI5f20XSoYlVbwpvQQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OS7zudT4niIYrEzlg/1vbKo3iBK/dqWCLmfaHG0xsnVoYT8AOkfh5Zb4cVOtPScYqdb7gPAl2+kM28Nu30IozANQ0r2VXG5wN6hAJXV609atqtTwrYcC+7KBjBp+y18KjO+4j97eX4W4fSKkcZxNBbf2edBoda78MOZfRDMzhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4OrSS4x; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4OrSS4x"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bed2dca324fso310273666b.3
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780792878; x=1781397678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIc4Vdvungi3qkA2df3LiMCfTnpbTVtTcJ7k45yeXRs=;
        b=q4OrSS4x24TAic82A8AN87xAJs6wgbq78/t0ERZTCyNtfdSZPxxStd7b5kId4uV82z
         Td7wx/9LppwE3rX3YPEB3xF7+Ei0mLhffTLaIdciZ01czbxN7XvzY2ra1/myLG1Ker8T
         DEsngLg1FFdeGB64kimn4fhj6QmzJHA7FHbRhIjFH04IxSi5aO4OBNePAj40G6DVDNg4
         9QUIgLnbVTUMN8kj2yif3Tj8nwX/ia2PzkHhdxyRL3PaO7+FJWg1s+jtgd5UBGAYNFHb
         6MTNPqKTz9cpMD4mP9sDziWJRsQZ7u14xV0ezveZGkbclelG3CL7X4vJpgREkZj5KM+l
         fLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792878; x=1781397678;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BIc4Vdvungi3qkA2df3LiMCfTnpbTVtTcJ7k45yeXRs=;
        b=WCeyWn0o+LZ/hCJMVu7TxQb9MU+51b0evzgcaEvAgCIZQ1gloyZn5xiVqjiMGLf7Q+
         VU9pHewBb5ebOe79zfbWE8nOlOgCNDH3z+PBkruX02e5OhG18uhrZY853IuqG15vPNlH
         TRZxT08M94vOkEqEHcEl/GEZDHFOnwQgwrGINbCFHT2vZfqQkxK/V9JZqsDrDfGT5pym
         D5oTLjFZgabZWDLyGh9DuKiR2/o8MHlFQqIsSirXP/eFrP9JnexhR1GnpVjLJfu52I3x
         TZ79ox8KrnZcgpLu3u0GnWSsIzEVM2HyU2graKQcunil37NHFUey+SvuPiG7pW0+Vt3z
         js3w==
X-Gm-Message-State: AOJu0Yw7FyElGxgJMaH67LJaq/UWEdcVRqWAy1Ki/69k2YlpS9RrbXog
	XknEV5A80ykR3fyOUi+rPSIzWe0Rhi0SGXkbnQiZ+cp7VciX4Cyp8qvpHJmhcd+9L4mMlomgBJZ
	H5VW6CjdK5uf6ct7Piw==
X-Received: from ejah25.prod.google.com ([2002:a17:906:1119:b0:bef:3b02:c49d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:160f:b0:bed:2a8b:3e73 with SMTP id a640c23a62f3a-bf3739f9bc3mr519953166b.41.1780792877841;
 Sat, 06 Jun 2026 17:41:17 -0700 (PDT)
Date: Sun, 07 Jun 2026 00:41:17 +0000
In-Reply-To: <20260605172418.012811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <9huzecijxjv6.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 01/10] liveupdate: luo_file: Add internal APIs for
 file preservation
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

skhawaja@google.com is working on next version of this.

I will ignore the sashiko error in this patch, as it is just to make sure
the series has its base requirement. This patch is being developed as part =
other
series. So I will pull latest/merged version as soon as we get.

Thanks
sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Nested acquisition of `luo_file->mutex` causes a lockdep splat w=
hen subsystems retrieve files programmatically.
> - [Low] Missing EXPORT_SYMBOL_GPL for `liveupdate_get_token_outgoing` and=
 `liveupdate_get_file_incoming` causes module build failures.
> --
>
> commit 3b62824c5e4a0e08095576efe5b452875a92a685
> Author: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> liveupdate: luo_file: Add internal APIs for file preservation
>
> This commit introduces internal APIs to allow kernel subsystems to
> programmatically preserve and retrieve file descriptors during a live upd=
ate.
> This enables subsystems managing struct file objects directly to particip=
ate
> without solely relying on userspace interaction.
>
>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>> index a0a419085e283..0aa0b4e5339f3 100644
>> --- a/kernel/liveupdate/luo_file.c
>> +++ b/kernel/liveupdate/luo_file.c
> [ ... ]
>> @@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct live=
update_file_handler *fh)
>>  	luo_flb_unregister_all(fh);
>>  	list_del(&ACCESS_PRIVATE(fh, list));
>>  }
>> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>> +
>> +/**
>> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
> [ ... ]
>> + */
>> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>> +				  struct file *file, u64 *tokenp)
>> +{
>
> [Severity: Low]
> Should this function be exported?
>
> Since this API is intended for kernel subsystems that might be built as
> loadable modules, will leaving out EXPORT_SYMBOL_GPL() cause module link
> errors?
>
>> +	struct luo_file_set *file_set =3D luo_file_set_from_session_locked(s);
>> +	struct luo_file *luo_file;
>> +	int err =3D -ENOENT;
>> +
>> +	list_for_each_entry(luo_file, &file_set->files_list, list) {
>> +		if (luo_file->file =3D=3D file) {
>> +			if (tokenp)
>> +				*tokenp =3D luo_file->token;
>> +			err =3D 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-ker=
nel use.
> [ ... ]
>> + */
>> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 toke=
n,
>> +				 struct file **filep)
>> +{
>
> [Severity: Low]
> Similar to liveupdate_get_token_outgoing(), should this function also be
> exported with EXPORT_SYMBOL_GPL() to allow loadable modules to use it?
>
>> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
>> +				 token, filep);
>
> [Severity: High]
> Will this cause a lockdep splat if a subsystem uses this API during retri=
eval?
>
> When a subsystem's .retrieve() callback is invoked from luo_retrieve_file=
(),
> it already holds the target file's luo_file->mutex:
>
> luo_retrieve_file() {
>     ...
>     guard(mutex)(&luo_file->mutex);
>     ...
>     err =3D luo_file->fh->ops->retrieve(&args);
> }
>
> If the subsystem callback then calls liveupdate_get_file_incoming(), it
> recursively calls luo_retrieve_file() for the dependency file, attempting
> to acquire a second luo_file->mutex.
>
> Since all luo_file->mutex instances share the same lock class, won't this
> trigger a 'possible recursive locking detected' warning?
>
>> +}
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.=
git.tarunsahu@google.com?part=3D1
