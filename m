Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401C4F55A0;
	Fri, 25 Sep 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369472; cv=none; b=RxxQJv6cUcFcyPUxKqIsz9tVLouK5+eaDQpcITGOluZuUNLa3oLBHaKYFcEI+QWky6EvL/8oOrEtXQJFukJovRbj1HrVa3gjg7LlweZSyAv/t4hwrBg18+0jpNaMWkAC4AUTdPU8BudFbus7KYPcizAVmbj1k6jPLU/KKdl+DwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369472; c=relaxed/simple;
	bh=LhRcKgNvoLjyN4xFtM2udHKKFIZPlinh3mfS3FMpzMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxeLfiqxaIO7qXGP4Rr1ELx1lfFu8FxemBI1jdM4LfGDzBGfkWzUGjgIW/fdPlhpVzpjzmuTN1TomG4AfTNehJbC7qNmeSI3pfk86vtAgxAt3HRrlXgcJ+32VrXOC4yVxnTc5BMlTY6vvDUYQzTX62p872zcbqNEgpFWdS8dk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=er5OzoKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4mBwLIW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="er5OzoKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4mBwLIW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 84D5FEC01DD;
	Fri, 25 Sep 2026 16:51:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 16:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790369468;
	 x=1790455868; bh=qSRQ1ky1oOOVBP7afZPXrD58/Crl4XDoSz/V4QbbroQ=; b=
	er5OzoKMOE2LQsCyr1IPzrUm3OyrhCmfPada8wHPdd4t7r6y7WDj1XZ3YF+w9RHf
	rjkcjlok4+1dPiKeEgaye7/yumKqzkU7qiFdy4WsNN2zUwPs6mm+CPks6JzUhvFq
	taF77ki5K0erXdEm/QdgQwvN5WK5zasVKzVs/3Oiy+F+zK4ce+dgyVa7D+UHdYQq
	mBVqKprHYT5Xs0TnlT+T7UPy2miOuegb2afl0OrGecw1sHLacrKNUiPpEYAcVGtq
	FJi7HsfCqjgFhfCt9EfrXjnK7gJoxwWb48Vx2DTqlLKP5l0yipSLPiq70y9FbQCu
	io0Qxe82hXmcd0VRDXWPRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790369468; x=
	1790455868; bh=qSRQ1ky1oOOVBP7afZPXrD58/Crl4XDoSz/V4QbbroQ=; b=R
	4mBwLIWULf+uyxGhW81ULG4t03jgWV7adoeRGeVKCr+C0+ejrzUr++a1fjJj44qK
	tij8qcn6EZP2yoaj4q6lq24Lr4Y6xk+CP182ngTetcdQX4eAu22MtNQsZhN/kR4Q
	Xj+ZFAQ227rzBK2vpfC/JjJn1CkWRzZGW9vRV9tkT9fqG3SPMk5wXGyhX+iz6//R
	9MxSKIe2tLyKyksE0gJC8wgrYF0VLuOaJrwB8tVwyvbaujwTVSOefZv1jT732dd5
	vv721wphAfkayTNEJB6X9LdP90OtZFWt8GaBlJ5Hm95NsETvi4b0lEjVfeWifMVX
	mo5OvdGxPbOvpWZKB8UoA==
X-ME-Sender: <xms:vN62ajlAK-ZbemMDIdPqQTBV_q0YAhmSHKJa1tSRSkw4DWgCDaGHmw>
    <xme:vN62aoW4SgS3shvpFTb3cSxAmTbj4cPS5-PlEaFzsDye2ORF4ZC50myQIis8n_81M
    kPqhYntOH9mBTKfkLTAp0BssmPZVySsuuj0K3-fW1ulTJ0B6MXqfQ>
X-ME-Received: <xmr:vN62apvLSZspIvNqhaZsfrXQ6BCo8rg8olpSxGCa6kG_qyWTfONj_hbrhsFcnw>
X-ME-Proxy-Cause: dmFkZTEgwTEguWhYK8o9jWcBD6hu/AqP91BKbQfWjtLjyfH5enizAvatWSq9Td13OYp/HL
    2YDY0tAh2nq9sPB78xgrXhW8YVwhOgsa3DUUxkyRHI1S4/N60UmATxnFVqtpm574tfp11E
    FDeqYK5RDP/hsxPeGOWcMHRT0BhELP3uU3CIRX5A0A05fw0c8Vgg8JqbAMqE0RREW2MtL3
    Hf/1bzQdQjDvmm2QLxv6PiXWcO4OYu8nmy9q46jQhH3rzZ779KNKBpGKnNnGH7db3BCxqH
    hpE5rIMWyajGwOdMQg+ANl0f4eBUJoZpOwejk6sh+cynexNHtmQCjFl2kDpLj4rb42KisG
    MmVg8sTG9WE20U+DNvS9QwnzceFPmSFk9oaPz0DPTEyKAuXWgB9k0j/6mtvOVPgIBY6aCv
    +AXnmXgJqqe7vM0t5HpLHmuyX4PZP3QXFreoFxcMxALdZWT8ICSGECzRD0TFPQqZ6TcyoP
    +Ln8PSQznbjOHrFmwy/1xA21QE2O7hFpuDtvuwZaMk15FXZsTlDzXMMZPVcjy2AFd2f7cf
    jRRASgsY5cITxooSWYwjwPnUGmzX/O1hTTkPt865EYZkzsomRmqJhHtLaqoOe/ld8rWN01
    VmPc+Q29I0gaQGzZ01DF3OTpR6rmTS12IQcy7YJD+G8HCdhe7fAIzkuCqDZA
X-ME-Proxy: <xmx:vN62arZMOYzpBCT2D2Wjsknj3Ob8AYx3rUbDfQ799KXVtXxn1ajYHA>
    <xmx:vN62aoV1UhE2mSZkWM1sVuYUinHY0OjjHs4cmz_BuV7SGnf6EO6Ytw>
    <xmx:vN62agTJvhkBWhpz-DTcYg8vHqBYh2PvB9JLFEUAyMwuOHQ63Cnncg>
    <xmx:vN62amOJSG8zjQSzybCJSsYrmQ5AuG1euvkZa0YxxXRFAjEO33VurA>
    <xmx:vN62aqzB3IXMoxVO1PIcAJdT69BqIrcY9ImgP8gpE2DabyVWte9imRwR>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 16:51:07 -0400 (EDT)
Date: Fri, 25 Sep 2026 14:49:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio: fix typo "stucture" in comment
Message-ID: <20260925144919.653474bf@shazbot.org>
In-Reply-To: <20260904115109.6170-1-hemanth.selam@gmail.com>
References: <20260904115109.6170-1-hemanth.selam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 17:21:08 +0530
Hemanth Selam <hemanth.selam@gmail.com> wrote:

> Correct "stucture" to "structure", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 3b4aa0632fcc..34337292a9b1 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -50,7 +50,7 @@ static int mdev_device_remove_cb(struct device *dev, void *data)
>   * @types: Array of supported mdev types
>   * @nr_types: Number of entries in @types
>   *
> - * Registers the @parent stucture as a parent for mdev types and thus mdev
> + * Registers the @parent structure as a parent for mdev types and thus mdev
>   * devices.  The caller needs to hold a reference on @dev that must not be
>   * released until after the call to mdev_unregister_parent().
>   *

Applied to vfio next branch for v7.4.  Thanks,

Alex
