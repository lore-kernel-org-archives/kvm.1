Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98EF36B06F;
	Fri, 20 Mar 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041562; cv=none; b=bssHkw0J+rOF+SxEp5Fi2jIik5LehVOe0Uu/26ta+LQR1di1VuUdCXh8lRdBqCfWrx6q4ZSDI1QVgh8xsLm8CPA1BFiXlvaNTmKMAnXvyo1EwSzkLL8HhlqcXbz46E1txkn8/C+ufIM9+ZoELL6um1jvV0iWcbTvVp5IwsGmcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041562; c=relaxed/simple;
	bh=u+suUuhJGarhIVeSGJaTHhDRhf+0URnWnUGs976uT7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQrbdSzBI7FmkQU2zWDh88970BRJbSolpRDHh8l8Q+SFoNWpbM7GvBkcsITppUj6kCbZxd+7DxxB8/RptKuhKL8e8IpGfaCheIwbfK7eBdyeMTvI0bTllzsgnadK24myQrZvzjxCTxVkmykQdeBBQNNpk1z7QeVuqQf3u7JC2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rX/BucoV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vKC9h/lY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rX/BucoV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vKC9h/lY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C0529EC01E8;
	Fri, 20 Mar 2026 17:19:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 17:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041558;
	 x=1774127958; bh=Ri4XPs0JGCyhvjyIoVLgG3RHHgzVlvd49BtPql1BEW0=; b=
	rX/BucoV4QpeccXHaRg0i2T5lV8dZw5HxvL/4J9Ph6Pp0CtIQnrYFeI3hsCrkQ1B
	yOTEh323RfQapLNP/IJb/v2IQYxxhQuWMmlVYX2E8vO9gf2oIyo0sVWdwovHYK/Q
	7WOE9Y3zSGpHNIRv1OOL7LV9uurcpqBME0Qzr4EfahHf6L78/yFkZkFb/9MVLoYz
	TtKGeh5EMmMYsmx/pZOLpz+PJVCPsi4xPytl0Qw3iwlLaczUntlEbLH7ZnFvqwXu
	lIKkxYAKgTm7+g0+orUXsTIGFxmLGCr2cS52KcWwScCwL4CJ6m544nWgMCb96ioV
	PJUGiPcVzKFhaXF/ETnA2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041558; x=
	1774127958; bh=Ri4XPs0JGCyhvjyIoVLgG3RHHgzVlvd49BtPql1BEW0=; b=v
	KC9h/lY/HIeERSP0pRvopcpW873csVEMTderTMUUlQ4Y79FhFjeBkkwaD1RU5Hkh
	X8D6TkCj+s4iOB0fB0YlFmDsnkAHsDIt2O/PR6SPOfMOEGXzc9pWNlV9G8UCbYas
	uqGSeE0fIb9/PUB0HLjV+PPJc0W3t0SaNoxcSFA7fqGePdBMDiyehDPStRcY/cVV
	XQol2jDxpUB1Le5qVcTsl9fyALxIjDSS7M1ij3Sr1++IzETRDw/7Rv69V7Z0ofOb
	w/ZrUNZ7pcF1NkBpaz7oUYsjT1bmJxyA3u3j3LQvadg0sEv/yKPDTeJUeZKebxF+
	Lb7wRvf1URScmtb/t+sxw==
X-ME-Sender: <xms:1rm9aXrLYQXQ1Xiy-P4Q8EiXhp2ODP2wy2K1y9ISPIFzn3OuStadTw>
    <xme:1rm9afdMC2FGg4kf8wuLn5yp5bCLOvhLVJoGsOx3b8NmewsBszXxOAyjdRHwj5gYj
    bRN8A2-qlC6e36NATIwBBT7s_0z_m9kUaxedsfwto6ruJOdHdl8lUM>
X-ME-Received: <xmr:1rm9aerk6kt_Ma3OJlO-90o9cpDN8Eyzr8AwqBxNFfNbbyApUmBBtsKpA7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhoshgvphhhrdhsrghlihhssghurhihsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:1rm9aYEB_J5hTezVvdlBWlj2ALSFv3G0Ccx4O-Bs-cZPfFZD38yKaQ>
    <xmx:1rm9aWudfePPSiWwWLiG3CSSJsBoGdBKwIQAxwDlz9hDYRyE9eu8tA>
    <xmx:1rm9aSUPu7vkkkPQJWt-y8FnYd8IyIn5Cy0TixDbc_PL1aP8cScuHQ>
    <xmx:1rm9aaFDb61vbY5a17lCm6TmRsNQdD5b7SH3IrfpU7SVj-fFVuQHLQ>
    <xmx:1rm9aUCD5_LYOxlJcUCER_2Y0jnBneOL2qrnGPp6np9bBTnZwh6gdb_D>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:18 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:17:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio: uapi: fix comment typo
Message-ID: <20260320151748.299fd9ce@shazbot.org>
In-Reply-To: <20260316185617.166414-1-joseph.salisbury@oracle.com>
References: <20260316185617.166414-1-joseph.salisbury@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:56:17 -0400
Joseph Salisbury <joseph.salisbury@oracle.com> wrote:

> The file contains a spelling error in a source comment (succes).
> 
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
> 
> Replace 'succes' with 'success' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
> 
> Fixes: 607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>  include/uapi/linux/vfio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..63d56c1fbf6f 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -141,7 +141,7 @@ struct vfio_info_cap_header {
>   *
>   * Retrieve information about the group.  Fills in provided
>   * struct vfio_group_info.  Caller sets argsz.
> - * Return: 0 on succes, -errno on failure.
> + * Return: 0 on success, -errno on failure.
>   * Availability: Always
>   */
>  struct vfio_group_status {

Applied to vfio next branch for v7.1.  Fixes and stable tags dropped.
Thanks,

Alex
