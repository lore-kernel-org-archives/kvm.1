Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD7471263
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145374; cv=none; b=rOdhFP7e3ZgW4x6LSkFTmeJvTgIcJEy75dALohQgYJbTnK1VV8pX4wWLpFsL4zZe1x+V/4syXkK+EtyBkL+XDVBPQaYBYMRM+guW518+ZWIuMzRcAzSbzAqytzVLOhb4cLzlb/AshAC7tMc1aUvUYXYpWXLDzW1O6Z+OVEB/sr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145374; c=relaxed/simple;
	bh=y462Q+q8oUQGg7quqBwcm1RU1wGDkgobl8Os4e6L+To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kU6f1T001Frq6s8yQ2AteYzjeSe0Ektxhri9LCd6Bl3zxs0OS7dGoDSKeuMA8NIw9rdANjlRISrY6k+2DjI7ro7C9oGWRwDdZRaxBs/h6Ou4uYblJKPLo7WyVLW/ZH5KaVUw6xzmSP90rL0a5ydg9lCtx3FC2i+cWSMwSjIVMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=guBRGFUG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="guBRGFUG"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1273157f8f.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792145370; x=1792750170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfjtBumDUQtQeiNse/0/IpCKbiv0enjynpJ+UPte5LQ=;
        b=guBRGFUGeBaixX0VEDsxMkKT+NFfnIqndkBUVzTJS8P5mnh05QmjRq3PAzqee/D5M+
         C0Q8Ds/NM34tmp8c0B09exvlF7eMiRC1YIUA76/dCDxAclhsX0cNUGwjFC+VCGrMOVzp
         GiUjlIUsBUZ8w1zd6JgoTVT63jJl/wc2wUcNgQPy9E2WWZKhm6vJ0CsAcOibLd2puWvT
         d7Zz/O3j+Gn+1XyjDuGoEzogCpfc3RNSkxKtRQEQL1AMntQlidZccMhX8+nX2+tD8AKu
         J43lkWhcg9N2AM0hWcsBA7Z6WmuVNC7EGR5Rp73q33PyuDFtZT0V11kAXreq3uSK+0Y/
         QieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145370; x=1792750170;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfjtBumDUQtQeiNse/0/IpCKbiv0enjynpJ+UPte5LQ=;
        b=g2B1PaN3IZ/hqoMXtMC8tDjGpt/QmvGE/Mxc8nZ2VdXSQ4PvAw4EsDr/GxCxYBqCks
         nXp5F4CECjZXBdOhIapGd/NLZWr9v2G3lvgzJcQXrwn/QbjmREFxFmBkytR7bYE4cDGf
         6v7lXQ5s7neDwdRwe2UgsnS1AUPCRUjiKtmXsbzx/VUZeZlGPpZE57qR7Unz9Lg/q9eJ
         FxAOHFRMDSYwcx7rJsjXTV8hSn5uDLYOlFzvBG9iFg7zLdcr2EBE77BqSefseAg/GolM
         aQ1+XlTjITwt+nA0BbXMXoJ1e/I2UAXYegQvoBSbGjPk6wx/iuzjJNgE1ZR6gnpu9xrb
         I9Cw==
X-Forwarded-Encrypted: i=1; AKwUvBxVpmrfAg/jhh4jae7dJpvC4lkdRSFV0U7qDC7Lp7jMtd0szFWJw9ovrdBhfbqFzJrJHtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHbHBEizZ2h9OL/tDKW35IGdAvt99HOisjCtVz5bR5MRvmRh1T
	4JVPYfNTafKND4qB3SnD5//bKsC7CTNxhS4uG1BlyYz0ILgCLThrXYsoJrRQ+D3U20c=
X-Gm-Gg: AYBFou298JjeJTSr6nCFug7UwYRD5nC0pUJL6Oc3QPr+oeFHKvDYwBF8vLkV5jTYvsi
	mB6L1akyfQb/RdXBQLPTcLc2CwXzxSyLnI1JURj5BRR+o/oY3G+IEIuy6AXGHj8DXTzxoKaWjyy
	6i9XFyNR3MWFd3khuHSCGgvey4Zi/M3Aosbrif4uxodpO6lVX6cX0mDS86iLTwdjh2AJy9e9Z+w
	/1rYZfmcaTKEcfOGJ496HWZ+kiPLb9O7dYoOd32VVg2K661SDGRdipvTThBtkoClDa6G50Bjju5
	4afAWkvz9PtQJ6cSxUvvYxoxK79tWBnNyb3XssUOl6PSgY0TJ1sOR2b5fnU3w0qSlSBaUAjOoAE
	ytACppX2xVSDLPqBS0ucLumDZ73fG8Ct2HRtIxNt6bcgTDpyau99PtkZkiKWk0dgpAU0bZ+eBaZ
	NyEKsIF5WRY27wD/34amMB38ixMNFFNQ7vDw0k355SEoltppBAvbH2PIGCgFuqNCeaBQLfTHTb9
	q0JIIINuClmQuPiUxlQ4q/52L3cOa9ACMpfEzwolh8xdEN3P461pM6/uOm0
X-Received: by 2002:a05:6000:29c3:b0:488:764c:7a17 with SMTP id ffacd0b85a97d-48dba788922mr30073917f8f.1.1792145369626;
        Fri, 16 Oct 2026 03:09:29 -0700 (PDT)
Received: from localhost (p200300f65f19a904af4079c70d984f00.dip0.t-ipconnect.de. [2003:f6:5f19:a904:af40:79c7:d98:4f00])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48dfd4f5b2dsm4364872f8f.31.2026.10.16.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:09:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Nicolas Schier <nsc@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Raag Jadav <raag.jadav@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hasan Basbunar <basbunarhasan@gmail.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH v2 0/3] <linux/mod_devicetable.h> deprecation continues
Date: Fri, 16 Oct 2026 12:09:11 +0200
Message-ID: <cover.1792144769.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=y462Q+q8oUQGg7quqBwcm1RU1wGDkgobl8Os4e6L+To=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq0ffICy4QAVwGpwrBpebGe+cZKb2jzXNv49Mrv E/fwiNK8BKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCatH3yAAKCRCPgPtYfRL+ TmUoCACZSyCbbUDkUav9mU2UDRAssLukMQD6BaQ+B0KWo8b1Xz6YWELM2d76YyJo0NYic+F2ULL eItz6V6UkKv90SFZJdF9DN9xNqeLnGUdIGls3IPrNHwakGv673gnGajgixnjiMwscDru7+CCOvW GN59gUKywNo1HSVHKDQzbDvbzjRa5LNV6mUeEHUbUxo8HXf4OOBHqEi+yb7Caef8le+sulMswAu 9n7jAyMVSDnbIYj3OFhgVTpM3NlDGMR/l4Xg2TKJatULMGjgmV/Agq+HMoY5U6TUyRlMA4NoTnh Sx0oy1ru/ntYsxCLrQ0zcQUC0N23LmKi0EVB8Bce9/KOgCwi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

v1 of this series is available from
https://lore.kernel.org/lkml/cover.1789988540.git.u.kleine-koenig@baylibre.com/

Changes since then are:

 - rebase to v7.3-rc7
 - Add a header guard and a comment about why it's necessary
 - Add Acked-by: for Armin Wolf

Nathan identified two merge conflicts for v1 with commits in next. These
still happen and are easy to resolve as soon as the respective branches
are merged into a common tree.

Nathan already proposed to take this series via the Kbuild tree after
letting it cook in next after the upcomming merge window closes.

Uwe Kleine-König (The Capable Hub) (3):
  Move struct cpu_feature to <linux/cpufeature.h>
  devicetable-offsets: Include the needed device-id headers instead of
    the catch-all
  file2alias: Include the needed device-id headers instead of the
    catch-all

Best regards
Uwe

 arch/loongarch/kvm/main.c         |  2 +-
 include/linux/cpufeature.h        | 19 ++++++++++-
 include/linux/mod_devicetable.h   | 13 -------
 scripts/mod/devicetable-offsets.c | 57 ++++++++++++++++++++++++++++++-
 scripts/mod/file2alias.c          | 56 +++++++++++++++++++++++++++++-
 5 files changed, 130 insertions(+), 17 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0.rc1

