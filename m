Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EF246783
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000348; cv=none; b=I5P/y054hjlSKa0rYC3RjUR0qEdeO9PaESToYQX43ZRBB6UQRbrxqChBbRXb3Iz5dOw9bUckdO2t0ZE6/wWHnjMge4x91R+JVb0k1rTwrBR/1aQy9jOxiM4GnNCVbBZIT4QXkfU2YWs4BOrkI5UBXiwrmBlFY3vicyPUuTDExXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000348; c=relaxed/simple;
	bh=YeeC+2+2L+S8+5NDHnlYj5S1MfCL5SiHgjRm8O/D4Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhGEWbEWr6sDxbAjLCKOXPQ2MwBMHoG52hrzP9P1Pw0DpXK+u5R/lJxIvNrrpWYIefcFVQJOrjdF+/5cZwNhoW5dOcZcHs7IYGHDmhtZ4id9kQneBF25yAu0vmkODNd889wsDL40g1IS9kyl8aDFp9t8J7FKdnf6dOAoL3Z94f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NCoVhUqN; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NCoVhUqN"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so16447715e9.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790000344; x=1790605144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqbKKNT9ux8l56CK0pHK3up35FrU6+62NPcNC6MTw/A=;
        b=NCoVhUqNh1KeDX+AI/gI3baVbwsH8vT/EvyM1fDiRWfdRYUTeqoBCPfi80ir7uPKUS
         dI+AugkJt9KKYn4f/MU14AkxIj0jQXzq+xrzYty9smYF8o5440oUH9YeyiUShiG35TYn
         8Zm4GToTfnTBLaQrO+7lhE+DaPCZkozYpOTsGhX3uoanRwuEsieK4FZ7OMsoEatrjp/N
         hyFHkTI73a765SfAz8y4+jNOa8jjV54f7IIVFHRYaHP+2mcKDSy9jYQTO/y2xrf6dgtG
         iXwtYSL1OwdlfTYQ6OzTouqLkEujGaM4a6Vg1mnyxpD9+xE4RERw7FW+bKWFj1pWWNRM
         itnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000344; x=1790605144;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hqbKKNT9ux8l56CK0pHK3up35FrU6+62NPcNC6MTw/A=;
        b=hPG4uUgWf3PoUlniRMruXLuZRo4wvcmZF3XI4YD5LTrnZ6hmuQ1iOKI2KX11v5Bjs+
         8ZMUGEyxhwnZkecw5Bzg42ZSF+FxqEBN4gkKIfOfGQRRojlMl0lNaAfGuDNNPa4APbp+
         YaHKO9wMq8INFO/0r4DEGHpvktWJ2mEKba9oGtttnYhK/DgCL5X/ryFhGbriMbBiTrY4
         RP7+wO3Q5z0MvUTX5BG7sZ8x2x5nCSi9p/itI+QzyUa+PJO+4BPLh8E9HF0FdLWnpg0T
         aN4H70MUTBaD0RsfaLR473roKMIQlHBvNiMCY6Fu79sdM2gOwTKBQzipCLFHiA1s4/OG
         2vjg==
X-Forwarded-Encrypted: i=1; AKwUvBz1uecfAIbPXmXgu/U+yOuuVh0cxp1qfpDTj5KebCMe3uOiHXzT42tkk5Hbgqrd+G+mZWI=@vger.kernel.org
X-Gm-Message-State: AFuF++lKJbuD7cUm3FNrsK2nDC3bUkuoRw1Gkpmh95/9I/CzNJocmMox
	PtM/c5asUDOGRky9C30SdiKcQT9t6bP5FFNrhvnbWLht2R6Xbfcr+8RsYd1TqOJ33Pw=
X-Gm-Gg: AYBFou1ihuf/2T+Bo1esjOVLZKS4lKdLWC72iO1zFmawk4mJXaO74yqFfvBO2af3xBj
	wW7uuD09ZfCTpdsTlv/9DVQxHGkabduEp7HbPUEsLXnxDdpNjK2ygOf5KR6rQ+xz+BbchF4DuV2
	nnV8RBGPKjWEXBC6er14PxYhiyfUCl/gtbeuTp6TuVR2izd74YyZyIxpvzvYM72bCNp/glfRA2+
	qW+Ofw1YzObr2BrYmKaSDDskx68jg0PNMSHUGS1V3GTv60m4yxRABmDGeJTIAXjy+g0ZQODDSvQ
	Netx8xSUPjSuHR4fbqEQBOyRh0kI2nzornMjSHiaxISEjdvrV8mU9oV9mhCBQDPPzF+a22/wOpQ
	/J+VZEFHyAvslSuusasHQ8KBeBAp/Xd3eNX1B/4EeX2OJhcN5PbeJtWuX4CE2FKSBCJjHLJDWrM
	AWm8UL1NT3cTLCziQkotcbV3vGQqUTECzlvOVqd2zAG6onOQFeNwo0HDnDJxDtco9Elpd8Q5Qz/
	CPaG1nN2DIhqc4yWVL6gZ+6S0IMNf6SlGmUbYkYMxrFZSO1SAXDkqicN3jzDA==
X-Received: by 2002:a05:600c:698d:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fc5851ea2mr149001505e9.29.1790000343951;
        Mon, 21 Sep 2026 07:19:03 -0700 (PDT)
Received: from localhost (p200300f65f19a904d4f76eed31f2ef79.dip0.t-ipconnect.de. [2003:f6:5f19:a904:d4f7:6eed:31f2:ef79])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd068124sm226896045e9.3.2026.09.21.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:19:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Raag Jadav <raag.jadav@intel.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexey Gladkov <legion@kernel.org>,
	Hasan Basbunar <basbunarhasan@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Armin Wolf <W_Armin@gmx.de>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH v1 0/3] <linux/mod_devicetable.h> deprecation continues
Date: Mon, 21 Sep 2026 16:18:48 +0200
Message-ID: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=YeeC+2+2L+S8+5NDHnlYj5S1MfCL5SiHgjRm8O/D4Lk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqsTzI0TOeHEQB9Maz2NC3JCpfSuBkzPvIF0T5H Lqgf39rKXmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarE8yAAKCRCPgPtYfRL+ TmLtB/40aAYP3C3wo4bv6SBsJRxepvOO+jcl0y6KAeoCenvhnVPm/U5nlXY7fUlejd7q3fl0qIH 3wunXaEyWa7N0Hnxp6GBFKmtIyIshbBYavzyzDHP3d5fsKsZ6Ujrq+B/nKu8ErQAj6mJ/WiA/NW Z1n2h7rV+CZzXz2YPqlfSPmNoPgaAOubluHd4AG2oZE2ZXvRQFq/K1UITc7sQJfWHXCJVU22n3n 3M/ol8XaTDGelOFaTVk2GZcRRMLcy2GIMo/r/Is5xaVPfXv8VaR55Ome5joYVhi+rg/rpz9KFWS SyHC1Dd9naehhr1ePCR2X7eNJgguLkS34JjzQc5kFkpvoghu
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this is a next step in the deprecation of <linux/mod_devicetable.h>.
scripts/mod/devicetable-offsets.c and scripts/mod/file2alias.c are the
only users of that header that use more than a few device-id structs. So
their number of lines actually grows when unfolding the needed includes
into them. Still it is a reduction in build dependencies.

I suggest to take this via kbuild during the merge window. Would be great to
cook in next for a while before.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  Move struct cpu_feature to <linux/cpufeature.h>
  devicetable-offsets: Include the needed device-id headers instead of
    the catch-all
  file2alias: Include the needed device-id headers instead of the
    catch-all

 arch/loongarch/kvm/main.c         |  2 +-
 include/linux/cpufeature.h        | 12 ++++++-
 include/linux/mod_devicetable.h   | 13 -------
 scripts/mod/devicetable-offsets.c | 57 ++++++++++++++++++++++++++++++-
 scripts/mod/file2alias.c          | 56 +++++++++++++++++++++++++++++-
 5 files changed, 123 insertions(+), 17 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.56.0.rc1

