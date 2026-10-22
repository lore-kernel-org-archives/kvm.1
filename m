Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792686705;
	b=UxsQ1rZIZpfC89Zq8q4zNWBuqfuppfJyZoVAC71H73ht+qgxrB7/7Wdn2LWFhvLICs6f
	 Ld5TFGf4RXCqH1yDIWkmQzI0+yQRnwWrqMZPEqBaSGOM4WkxT4OWSjh3HjK8HT1kdt0x7
	 Playdp36iB3ALQ3b7yiJPTVS+cYNQeDWeAcfQz81yF51vN8pkZCgoKRF5upUfWfkQDLTr
	 fqOzh/BKASJqv9Z87kz+rPnXuXIj04qFqtoQ8JBiewtkuc7AbU6L99bHZ0Q+SEwSc9bF4
	 L/6zsDlA3jjiC7MAeSWXK9UYsspV+jVcuNWGvNAuw2Sa5nh4pFDe2SoplNH1DyoLoTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686705;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=OWR3Q3e3d/pc6155fxCnxozc2RqjxLkDdKmAHsnPwx4=;
	b=h8EDdB1pw05cb/OBPGuwY3ll8VS59KEn31EhF2rrDlwLZqPiJ6IshYyMv/3IDIs2ayzl
	 iNW6xEUyz/5SUAS4Wt1/l+qGnXCoBrfhrGPCLSJDVwC9t90j8sy/J15v/GFPIhPIdjaF2
	 u+HrguEfav4GnostkChMLFtf8N4vBN7HSNAF3Q0SP+05tRewHydIr7SYldbAsTaYkJAzu
	 McDz3NHsAbUPVvqh6rTsLjzW6I4tWsCjp8ChWr7JHGYSfP+UEjGn3PwVYwZJLqKolmw7j
	 WGySfvbKicAarmfjUfuTMt/V4fn2xoRljhtA6K9AE07GrGEUz3PVmvhZLmOXaH/QUvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoRLW8vR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA06606A31B;
	Thu, 22 Oct 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoRLW8vR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792686705;
	b=AqGSAoYpCH+wsUap7xA4YP3z2ukAnCAZePTOUv5Mp6WUhp6HlgkSxTLuuGHoULr5sHLu
	 946kFTsHQZHaPgizdBWPuCo7PntX+68Xn8yvNY94vhlL0GDG9ghRJ5PFqg5Z6SQwUthM4
	 rNaEtmzEK/QWQhNKLRj74O9XrzmvxPQSswHtQ2hnLpueLEl41nxPrCCBwtDON/yXujTK4
	 P+Qw/ZHUtf0bV3vCkEBtAItfDQmwEf+DOhejWJYD/DnoiQSw5frjhtdey3846PBm9736I
	 uWxBnmQcWl/ocoB6fxEofidIwbYs6iHKRRboHAaSP2PsRQmYWMSXz8U+KIFFyrrr2pQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686705;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=OWR3Q3e3d/pc6155fxCnxozc2RqjxLkDdKmAHsnPwx4=;
	b=N5wgtX3om580JJMtec/BIk7dhaqtvLC8RoVGTBjP1XPOCS99pUlV5arBXn7kdImMH4UW
	 7kmgtV6ZMoQyqRtR0Jfzlm9uUu9wMLTCvFp7y0X/MSYqI99E1emsf4jI0hLHBm7MruYwR
	 KnvxQBj0MGby3NXizTqjsYCfnVb3zAwMlMLGjrN42iG5rG0e7j9L9ts5ytNsEgPXNzrfC
	 8wnjIRn2KBVlZ9cuqqCanCORQmzW9tr7PNyPn+igGK9yhQtx93avd1juvd7p7IPgkmYeD
	 OnOKStdjKm5e1i6dGS1UvlpoXYLS2m9WV9FcSDmPivhWahZ0Bhjh5GkwGinDZqdT0hQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 93C9C1F01825;
	Thu, 22 Oct 2026 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686705;
	bh=OWR3Q3e3d/pc6155fxCnxozc2RqjxLkDdKmAHsnPwx4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LoRLW8vR2TtuW0l3gG/cZMgzbZrWaodxBOpGODKvoyIEbKQxlZe4PGjpdazEkHJJa
	 oBy3EgQ7YJQC4jbcJku1Xsy7GwGn4XUG2LbR1p2Kb9eE5O4bmmEZO/19SN3AeZWlF6
	 IIaEOEDepBb3k78ggZoNJX3yOmQt53CzT8CVp/ka5BK/cPK09k8WESLZF00B++D1Yy
	 cI7SrMKdGBYGoJKZ5fGrvw2Mv0ofvaYU+r9LYYtf2g3GeFliruqCb/p20tOu+Ih1+B
	 xY6IB+7e8EJV0T0Ha4Gi3KxG6PuqNU0tj3GPvlxe7GiEceqp7dIgW9ZQnVC3KAgoYk
	 0TL8/yijWz86A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 26DC241E5E;
	Thu, 22 Oct 2026 16:31:44 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Subject: [PATCH v2 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Date: Thu, 22 Oct 2026 16:31:40 +0000
Message-Id: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>
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
X-B4-Tracking: v=1; b=H4sIAGw62moC/4WNQQ6CMBBFr0Jm7Zi2iUJdeQ/DgpYp1BAKnUIwh
 LsLeACXL3n//RWYoieGR7ZCpNmzD/0O6pKBbau+IfT1zqCEukuhJKZ6wWYiTjhOIREOoetQuNw
 4e9NaCAP7dIjk/HJmX+WPeTJvsuloHUbrOYX4OX9neXh/LmaJErXUVZEXUpE1T9dV3JqQ+NpTg
 nLbti8JCUDJzgAAAA==
X-Change-ID: 20261021-tdx-guest-quote-poll-0f7bfc59900b
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>
Cc: Jun Miao <jun.miao@intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792686704; l=3531;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=DYmK4oPQkThsFh4mvvlu6tFsPRIGyH2P5nY+9Z1k3W0=;
 b=/hezUodkMv3i/qPGzbVp7F0293YaL/KtY9UMvJD0VEFGPsx4CbQuFrYTgY8WYpCt0OeHkM+aC
 YDsXU+U8SljBtVevMD2pvO1xwaPSQcRLr4cMy/OMrYZxycy9RixbJEb
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net

Getting a TDX Quote takes at least one second, because
wait_for_quote_completion() sleeps a full second before each status
check, while a local Quote Generation Service answers in a few
milliseconds. Patch 2 polls with an exponential backoff instead.

In v1, Kiryl noticed that the same loop gets a real timeout wrong.
Patch 1 fixes that on its own, so that it can be backported; patch 2
then replaces the loop.

The GHCI SetupEventNotifyInterrupt mechanism would avoid polling
altogether, but it relies on the VMM implementing that service. This
series keeps the existing polling model, which works with any VMM.

Jun Miao posted a patch for the same latency in September [1]. It polls
every 2 ms with read_poll_timeout() and lowers the timeout to 1 s, and
has had no review so far. This series keeps the 30 s timeout and backs
off instead of polling at a fixed rate. Patch 1 is needed for released
kernels either way.

[1] https://lore.kernel.org/all/20260917102202.750895-1-jun.miao@intel.com/

Testing on mainline a804c5742 in a TDX guest (KVM host v7.0, QEMU
11.1.2, TDX module 1.5.34, Intel QGS, guest HZ=250), through
configfs-tsm:
- Latency, 40 back-to-back Quotes: 1021-1024 ms each before, 6-12 ms
  (median 8 ms) with the series. msleep_interruptible() rounds up to
  jiffies; v1's usleep_range() got 2-3 ms.
- Timeout, with a QGS socket that accepts and never answers. QEMU fails
  such a request itself after 30 s, so for this test getquote_timeout
  was lowered to 5 s: without patch 1 the request fails with -EIO and
  no message, with it -ETIMEDOUT and "GetQuote request timedout". With
  the default 30 s and the old loop, QEMU's error lands in the last
  sleep and is reported as -ETIMEDOUT, the second case in patch 1.
- SIGTERM to a reader waiting on such a request: it exits within one
  10 ms tick of /proc/uptime with the series, as before it; with v1 it
  took 110 ms.
- W=1 build of drivers/virt/coco/tdx-guest/ and checkpatch.pl --strict
  are clean.

The patches and this cover letter were written with an AI coding
assistant, Claude (Claude Code, model Claude Opus 5.5), which also ran
the tests.

---
Changes in v2:
- New patch 1: fix the timeout detection on its own, for backporting
  (Kiryl)
- Patch 2: msleep_interruptible() with a 1-100 ms backoff instead of
  usleep_range(), which sleeps uninterruptibly (Kiryl)
- Patch 2: secs_to_jiffies() for the deadline
- Test and tool notes moved from the changelog to this cover letter
  (Kiryl)
- Link to v1: https://patch.msgid.link/20261021-tdx-guest-quote-poll-v1-1-919a87812ecb@flashbots.net

To: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: Erdem Aktas <erdemaktas@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
To: Dan Williams <djbw@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Moe Mahhouk (2):
      virt: tdx-guest: Fix timeout detection in wait_for_quote_completion()
      virt: tdx-guest: Poll Quote status with exponential backoff

 drivers/virt/coco/tdx-guest/tdx-guest.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261021-tdx-guest-quote-poll-0f7bfc59900b

Best regards,
--  
Moe Mahhouk <moe@flashbots.net>


