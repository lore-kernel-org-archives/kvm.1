Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165971;
	b=DbncUnhxjSAUwJ6f15NkhGrcvK/NoeFzNMbaV3qka0pDzNuTy61eiWgmcCA/+ocrvNPO
	 94GEekRSbB0Yj/ZvsoM+6hhsUPIfzBkf2pXEjJ4I+M8FF5EJ4z6tGRfub38zPI0rpDsfW
	 tbwJI0TA9isdz6sEIeF+ZNt/PCsAOqPXM1IlhLsSJ6p/gXcEVlzLYnt6wbzY/PBsH3Q+V
	 grStvduiRsdVaT3XU0cK3Ct6lQFF+GRsqnl9oK7NsXADlgFbYZA3AIJRW2IF0IKIkL1M/
	 m92zUNavYqVhgCN47/2H3o5L2kM//Ot7TF0CAazr+30EKb/bFaxmSdTSWGlm6sJOlsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165971;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7EGu+YSDO7LGtdXz5YjqyDiKnsMSMnT8rQzzEXbjKLA=;
	b=dLuqfAaspMC4f06JfKaOkI+VajMHeu8uNYeTmcDC249+701y4SHolJjb+/rohqS7Y08D
	 ge8MU4DF6mDmoMfHJ/VA6eqBqQ5wN6jQkkBFTYaJPRH8Gply3qy71rxfUN1IW7o8OINBK
	 g/2ZIp+agDqOmxAQaO9Hj5AyJYog7b/BGi1msp/rwaf5obQPXSrT0QIJQkaouJqTpRkCr
	 U0IqLX235nyGyL5KfgiN9C9HMhTKayEz9gvxT66OzTqWOgkoOo0A9pP3mi0iXHj+yzQq0
	 SmyCspJShqbQ13B8z3PW697W3O0orl/QSZaLr/rSdNaJMXtVezgxYp3Kc2Ikl9dnlqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0N5DkU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3BE84606A31C;
	Sun,  8 Nov 2026 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0N5DkU5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 61A111F0089F;
	Sun,  8 Nov 2026 19:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165970;
	bh=7EGu+YSDO7LGtdXz5YjqyDiKnsMSMnT8rQzzEXbjKLA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=J0N5DkU5fA6Xf8qOKlRzVnvxrZbP5zLF9omvL5YT9x68r5N5AR2DnxPF0is838+f4
	 k9VLms5fXr0+iXqYRzHddNL/gWh0rpwidd3lqFf7MPEG1B9KUnMi5T8KIW38fl/FLn
	 eP5IYvG4qaCTgQa8F8Dz2zP2at7ZVeX8AHZpPH6wNOld1XfN3zVM1H3bShkyRaQUHb
	 A1/PORp8RtWgEpC+m6bDwG/wDbSYw8jMtno6SnITRvrsWs39xniJO+x6IeTBgeE0h5
	 1aTJhaeYyCdenxS+YZJ5BC1w/0Hg5zBWSDon0CcepKyUtshtjh+QUE9je7ACD2IM6K
	 6zram65I7Ujhw==
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/3] <linux/mod_devicetable.h> deprecation continues
From: Nicolas Schier <nsc@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Nicolas Schier <nsc@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Raag Jadav <raag.jadav@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Hasan Basbunar <basbunarhasan@gmail.com>, kvm@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org
In-Reply-To: <cover.1792144769.git.u.kleine-koenig@baylibre.com>
References: <cover.1792144769.git.u.kleine-koenig@baylibre.com>
Date: Sun, 08 Nov 2026 20:20:57 +0100
Message-Id: <179416565740.60865.16102443399828949110.b4-review@b4>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=VAPx+XY+bQ337J//6PGukivx0Hid5rbw9BgqEnC2/Qw=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBq8MubGxS86KupbtyVtfQGKmsgDdXwdrHjwvLkR
 QBrrmEGdOyJAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCavDLmwAKCRAHUgpwFiYS
 aSi4EADrogCK8zsVY0nw5fce7s91WKgv+ThHm+22mUyZevxukgoOQr+OcvyN69zwLuLoe5iWsde
 4b0bP7jKvGiELJhdUm3ASX0uqlt9nb4+Kv/uIpC68p1OAiBPapUkDjP42VGlDeDjXmSg5zmPh7M
 YcBEmNoqjYrLiOMfotWOVIm86wn1CeovwPOoHSy5o2glKSMENWcoBfD1lIYSlBAMTVDMq2tyWUN
 0c1iK4Doge1F8Xv4v9q6AbxhJ4XUJR7h5p3vnRVFIItDXxBQwmFoGD6l7v1yJ5QwSm/mDbF84yf
 IHX4pMPmwLM7nsosfim7mCYZuSBSHi36LWhVdKoCSdSOhV2Vo8QsFYyUA9n+Q6c5Dwz9NIwhxuw
 /gxE0k/wJ3YkqNWXGzJtDDamdEgdUNu7gS+YENoGh0SIH4EQ47gooQJO70ajktC/ZpzCCCwOzCX
 TC3AZWouCZKjItvA5dbfE8AGLhXye5LQPpNLzf8jX+sI83bn3gsW1IbsFOCYvwR2/TBHh9wKGUf
 zsv6svwSvxIWO+Zq98PKY4blYU+M3g+ilVrKslM8uRn3Fcfh67pEm5374LGosuBcKeh9BoPsJVR
 AaUY7A+pobVgXK7WYlH0ymO/u/iOTrT/qZRcXZ76p+sQ6BEN+ijIC/0hteLbcGFkWezpVqD3zis
 EJEcnhkC6ZdwIZg==
X-Developer-Key: i=nsc@kernel.org; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F

> Hello,
> 
> v1 of this series is available from
> https://lore.kernel.org/lkml/cover.1789988540.git.u.kleine-koenig@baylibre.com/
> 
> Changes since then are:
> 
>  - rebase to v7.3-rc7
>  - Add a header guard and a comment about why it's necessary
>  - Add Acked-by: for Armin Wolf
> 
> Nathan identified two merge conflicts for v1 with commits in next. These
> still happen and are easy to resolve as soon as the respective branches
> are merged into a common tree.
> 
> Nathan already proposed to take this series via the Kbuild tree after
> letting it cook in next after the upcomming merge window closes.

Ok, then let's go; I am going to put this on kbuild-next-unstable and
kbuild-for-next.

Thanks.

-- 
Nicolas

