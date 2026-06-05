Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73984386C24
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680259; cv=none; b=cbbITxAot+ls4GDtpKYPvSOE+Q6kC0M/bYF97wcGRL43XfPlgXuPoQdwZySBaRJ91TyGiHLOcu3TIBn8Nc59/ztaAQhJRzRfuajGvMvGvewOgJny1KhxuQx8ltmvLFzArGTuIiPYskQ5Yp3LoXlmgSvQ+ZV0RGkBrN4fAZ9DUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680259; c=relaxed/simple;
	bh=r3OuyW/VOWaQTWD6FwbbFvhL8Nxdfu8RThpchA+MwCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hGiU8DKeV2eHGRUq2hSSQRBpQBaAwHzORkiG+dLxzw8RovlP6PF/3el4zzs85t6vC1AFbNqrbpFYHOU/BM5BKnkTtnx2A9Z4nHQ0ZFyf6EDgP99jKktMSDdLOxtCtkTbZpFw2Depj8y681moVGKVfghXOu6eiGXS6g9mQ5rCni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJlTEEg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJlTEEg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012811F00893;
	Fri,  5 Jun 2026 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680258;
	bh=s7jUHkasRg5VTpoMQ1lkh95bHJ+zczGu/MJ7mSAFIq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJlTEEg9qzAjoMCH3z528/P1LNB9r8mYi1TEv8FRd5LbgLPiYnr1otbe80muH4cEh
	 2CtG+dD+NJjl2ygjmb7d3xBsGooAQRVNnDdaToGsjG58slnrcpP1vw2IQkylkwl+j9
	 YVE1U53SC1Wb59HzEnB2/tM1wnYwqFoIPGqx2qH6Pw7rGbBLuiIQsQTy5kXOXgyaKb
	 IGYk16Evv4iwaTk2CIp+GwI2L5KWNxWxc8x0CQINrjoIb/TZAVuOTyaswBO2VF8yGs
	 FvBh40yzisvDDX5wcGXanj+VM6cfyPFA1uejVXb50gwPfZQhW8+8efr9My17sGv0cr
	 67zIA9DFMeRjg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/10] liveupdate: luo_file: Add internal APIs
 for file preservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com>
References: <c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:24:17 +0000
Message-Id: <20260605172418.012811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Nested acquisition of `luo_file->mutex` causes a lockdep splat whe=
n subsystems retrieve files programmatically.
- [Low] Missing EXPORT_SYMBOL_GPL for `liveupdate_get_token_outgoing` and `=
liveupdate_get_file_incoming` causes module build failures.
--

commit 3b62824c5e4a0e08095576efe5b452875a92a685
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

liveupdate: luo_file: Add internal APIs for file preservation

This commit introduces internal APIs to allow kernel subsystems to
programmatically preserve and retrieve file descriptors during a live updat=
e.
This enables subsystems managing struct file objects directly to participate
without solely relying on userspace interaction.

> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index a0a419085e283..0aa0b4e5339f3 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
[ ... ]
> @@ -924,3 +931,65 @@ void liveupdate_unregister_file_handler(struct liveu=
pdate_file_handler *fh)
>  	luo_flb_unregister_all(fh);
>  	list_del(&ACCESS_PRIVATE(fh, list));
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
> +
> +/**
> + * liveupdate_get_token_outgoing - Get the token for a preserved file.
[ ... ]
> + */
> +int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> +				  struct file *file, u64 *tokenp)
> +{

[Severity: Low]
Should this function be exported?

Since this API is intended for kernel subsystems that might be built as
loadable modules, will leaving out EXPORT_SYMBOL_GPL() cause module link
errors?

> +	struct luo_file_set *file_set =3D luo_file_set_from_session_locked(s);
> +	struct luo_file *luo_file;
> +	int err =3D -ENOENT;
> +
> +	list_for_each_entry(luo_file, &file_set->files_list, list) {
> +		if (luo_file->file =3D=3D file) {
> +			if (tokenp)
> +				*tokenp =3D luo_file->token;
> +			err =3D 0;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * liveupdate_get_file_incoming - Retrieves a preserved file for in-kern=
el use.
[ ... ]
> + */
> +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> +				 struct file **filep)
> +{

[Severity: Low]
Similar to liveupdate_get_token_outgoing(), should this function also be
exported with EXPORT_SYMBOL_GPL() to allow loadable modules to use it?

> +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
> +				 token, filep);

[Severity: High]
Will this cause a lockdep splat if a subsystem uses this API during retriev=
al?

When a subsystem's .retrieve() callback is invoked from luo_retrieve_file(),
it already holds the target file's luo_file->mutex:

luo_retrieve_file() {
    ...
    guard(mutex)(&luo_file->mutex);
    ...
    err =3D luo_file->fh->ops->retrieve(&args);
}

If the subsystem callback then calls liveupdate_get_file_incoming(), it
recursively calls luo_retrieve_file() for the dependency file, attempting
to acquire a second luo_file->mutex.

Since all luo_file->mutex instances share the same lock class, won't this
trigger a 'possible recursive locking detected' warning?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.gi=
t.tarunsahu@google.com?part=3D1
