Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669E3F20FA;
	Fri, 12 Jun 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283373; cv=none; b=IQi6jV00/BJunTPwc8mMaINvPSYakKp1S48yOqK7p7D1UyXP5Pnc+Nk2EzgqveLPybn4jE3nsXOP55LZwmfT+ycdltAAn9uxCpB0m95jf/fnYPw8vadrEvwhwPI9TXYIAJIvoROcKMl6iIW0XIWTGKqHSFBetcqFf9omGVRhzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283373; c=relaxed/simple;
	bh=BsaPWhUx0EGjnI6qMzqjpylMoxg7EyOQ1owSQty07As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5apCtbG8sKGnVOaG7oR1RrETaepRjIvRhmcivG3u0nomGHAii7vqTHYPn8/8FvQPWRcqL/6qI6pfXL9feBh+tYixZ1SqwSUUi4QG+aQ7R6to5B80OnT512Bq405Bw7YuSj9/0D70RshBD07WVH7dQeaTiGx+WgTHuPy3li3JlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QQenQXjb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMEzlgzl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QQenQXjb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMEzlgzl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 63B91EC01B4;
	Fri, 12 Jun 2026 12:56:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 12 Jun 2026 12:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781283371;
	 x=1781369771; bh=kztjFFoEP8L+EY9gpPvXE6722RPrTb/+ExtA2l5TQ+s=; b=
	QQenQXjb4JOnPUK4Rt5ub75q2pPVEwPKWz1Bt3pay5sovPmfZYiheNDbkbi79Ytj
	GKmrfVDJCUcmReBOcjcKfiO41LRshPm758kJsp7Dd0vJ7K80tWgmpb0PiRjGlucZ
	gFCs2bij1FwSuxfloLyXF8P7JFaoyWoAg4aCbaR04uI976mdmJFe4k5R9BHg/VSk
	deizBJQ5FYarRtbVjL/KPDGriTV/0pdcpCqKt+Yr6V85ukZ3V5NR05TGGC499ynE
	1T/W0Ytc7slzXrdtndOsAXrNooBgJbiZt09jj01KzmBT0ph8OWlfZxWw7Ebz4eqT
	msq3rQwKGP3PUk/2TcrTKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781283371; x=
	1781369771; bh=kztjFFoEP8L+EY9gpPvXE6722RPrTb/+ExtA2l5TQ+s=; b=Q
	MEzlgzli3MR15abm7u4RcvRobTM3cdXe0y06IjYI3Rc/ytceVFoo+umYkePlC6bc
	OXCY0mkLhBqc062zVdwsujlNzKvrSi0BzI0vYtZkfoL3Temyk+8z9y5FjI/cKAYE
	Ttj5VJT2m3xZaAZQNQlm+sYqCc7s7yRQe4yFu75GIpQRC9W51+hihH25Ss3wgPML
	yCCY/4I9hWU7PrESM58MZM31suVhyoGy90ryYlzOvAPHHCq1jJ+UUK/ZqDvllc5f
	AvLbzhBoZGdDCca7Q1FUs3jzrvnf7IEw0fyTJFqFy249t4q/5PdnyH1Ydrinx+ni
	j84yM6j9qXtGp8DrLCU/w==
X-ME-Sender: <xms:Kzosagj_wg0HOM8pE0apJNFI4QO1P0lAZJ-cn8mkM91mSJ38MvrE-A>
    <xme:KzosaiU2dfwCTlvKyixX0pBVqtAu_TrPrXTfeIHqzwilWIZFu9SabXg0MSEhHdejA
    OlSKOmiVnWt21mZ6y_he-tCOU4f9s8lIvI6csAIcC-yHq30_G0WuA>
X-ME-Received: <xmr:KzosavUaHzMOpU1wA069lbc-olvKDSjAj30BQLAKWBvckY0m1sXLjBLkm6M>
X-ME-Proxy-Cause: dmFkZTF8QBbZv7cC+ZhUjkX3Vx7h0gtFINGAXMpX/b5+ozeMgnU7/Z8/5mJIyUv2KTBP+h
    VT1UnDmpjhXxKWoIsyHzQxFcZuiVGuDoupqsz5fbH0jMP8MhClaocu5C/spy2mH53/m+Qe
    S4D0PzAiJRJ2Pc5HmxfOy67xz3PU6og3xdEyM8LTNE0LKGDnaq6hdAOQu+aFzNdWplTXN1
    YxUKh9KIQQBPHJf2xb1xt8uPXdF1srmGOMyxqwEfNp8hbotKpI15eHcWndND3JD0/jkgV9
    nwFWljzcSUCQzF2U+Liqulc/PbN7WUMPc0upf6ms3o/Mi3VSdBhiI+Apq7TRnM5aIkJPYS
    KZ8l45gq2GuZ6tIYjafwIzW0a4B701+JjUYJXFo+tZEQ1VrutBHNTUEAH3KhEL59uGR3E+
    A6WE1suZ6x5TdxngpeldWc/mqLy9JhRu8DPIaj1v9sIPT7e7/ovwuvvgSFtXLCROcyijdg
    UeVkv0JGpsar9GHW1LcKpH7rBda0GNG6G8/Z6qC9rZkwJJJtLiIHXsov4DM64cNBccxcWO
    Qfp4oD9u0M8GvLzV8r/WCFQr10BHtbh7p4Kz3nSNH1Hpp0roRTj8svy9tTz/nE7oPfXomu
    GcWYEZLYPRgIvgZ31G4nlOlzH39QpdjDRso6esleXIBqYENgZCxWAWpHskMg
X-ME-Proxy: <xmx:Kzosaii3gpWFW-jREZ-CQRitXIPa0DJ4ecSreXKANne9P2M8T5ZBhA>
    <xmx:KzosaqZiHrDg4CAP1Dq-CZaBLpWSIbD693qBgROIergNq8s35ZSLpg>
    <xmx:KzosavooZy0rJ79IE2A1w9GgoqGzssztG3cofgQtKwxot-0JaO3iXw>
    <xmx:KzosanPqeIGPGIpc2MJjeLK4jioIZKCuMAZKiwk-54vbpLTGM0DLpQ>
    <xmx:KzosakBIFewH4bC2sQEevyDe0HMvcXfcxYn9aflALG8xRAcc9jj5_8xq>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:56:10 -0400 (EDT)
Date: Fri, 12 Jun 2026 10:56:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson
 <seanjc@google.com>, Sashiko <sashiko-bot@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Ensure libvfio output dirs are always
 created
Message-ID: <20260612105608.2a51d84d@shazbot.org>
In-Reply-To: <20260611213945.3714421-1-dmatlack@google.com>
References: <20260611213945.3714421-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 21:39:45 +0000
David Matlack <dmatlack@google.com> wrote:

> Add an explicit dependency between the output object files and the
> output directories that need to be created to hold those files. This
> ensures that the output directories are always created.
> 
> Creating the output directories at parse time (current behavior) doesn't
> support the scenario where someone does "make clean all". The
> directories will be created during parsing, deleted during "clean" and
> then not available for the "all" target.
> 
> Use an order-only prerequisite for the output directories, rather than a
> normal prerequisite, to avoid unnecessary recompilations.
> 
> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260610010314.DB8861F00893@smtp.kernel.org/
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> Cc: Sean Christopherson <seanjc@google.com>
> 
>  tools/testing/selftests/vfio/lib/libvfio.mk | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index b7857319c3f1..2b8d73b7d329 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -20,11 +20,13 @@ LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
>  LIBVFIO_O := $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, $(LIBVFIO_C))
>  
>  LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
> -$(shell mkdir -p $(LIBVFIO_O_DIRS))
> +
> +$(LIBVFIO_O_DIRS):
> +	mkdir -p $@
>  
>  CFLAGS += -I$(LIBVFIO_SRCDIR)/include
>  
> -$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
> +$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
>  EXTRA_CLEAN += $(LIBVFIO_OUTPUT)
> 
> base-commit: a26b499b757cfc8bbff1088bb1b844639e250893

Applied to vfio next branch for v7.2.  Thanks,

Alex
