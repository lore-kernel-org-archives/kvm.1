Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28773BCD12
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269226; cv=none; b=kb5v2wyj3rm3awaFWNOZvmmL8EevDM220tWFHnRAxvaQd1e6P9Yr3hKsneel4ysCPnohzXM5OXcTX1nvo7vJO3JTnPVOTLuX2Bu4YmVSNjdzJgS5QxX53RuVozIkUM5BEsH1Qnhra0NWz60rAW1txMHTgkU9i7dvt9cKamKQXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269226; c=relaxed/simple;
	bh=q1EGlJo4k20wtjJ6LeZz9Ga195oecSYq4oH23A0N5nY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=jHkh2/LXf1xstudtUZBPmvLjR//n5Q5GYQmRcT7hgBwEMtXG/tWrVUZ8st9HEnSqTl1616EOIOvSdfXQ6HICjAGFpcdSoqsrlzhUB8k3SheTQG9ZzSfgtl/8p8f7ZJTcq3wo7Si6/5QvqD6ffpqENb+wgjI4jNkKjxICgmvlZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=knKc+KkZ; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="knKc+KkZ"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 013C71787C440
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 15:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788269216;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=q1EGlJo4k20wtjJ6LeZz9Ga195oecSYq4oH23A0N5nY=;
	b=knKc+KkZRsw4D1XOLeg/t19fbEy6xz2ObyD68nWBBhryn7haCmtg9A9LsPVg+MNO
	GKR8nReUH7QgN9BN7eE1pggA4wv0TkZn7pF2YLui76lyQlRfacx7ZyVKcaHQgshI3gl
	3Z+CVXNRHmNSfhw53H8yfOhR8FVU68HqMho345s2zGG+Rl8d9h4jN6SigWFHFekVTMJ
	iXx7ZQyGJ54X9EhvyeZThTlji3DwglkL4rgL6agx2ef63DES3teqgT5r0rTwXeVheBg
	XCUEPpl+J4pUPIIgIE70DFmc+eNSVQf29/RzoKurylNUJ0hfO0N5/EWRCDOmUf4ZDEP
	Rrd5+K2iZg==
Date: Tue, 1 Sep 2026 15:26:56 +0200 (CEST)
From: nhuquynh@tutamail.com
To: Maddy <maddy@linux.ibm.com>
Cc: Npiggin <npiggin@gmail.com>, Mpe <mpe@ellerman.id.au>,
	Chleroy <chleroy@kernel.org>,
	Linuxppc Dev <linuxppc-dev@lists.ozlabs.org>,
	Kvm <kvm@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <P0S7RHx--F-9@tutamail.com>
Subject: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 01f623faf350242ee22fbff0b8773ebd8a7767447f9b594d83172fa356399049e52c0826425050c9f5eab48b0cde0804d49efbc89e5dcad8f064d92c63df02326c:TurnOnPrivacy!:tutamail

From 80fd05e6d156d5a90d4908f2498bf6cc7acbdefd Mon Sep 17 00:00:00 2001
From: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
Date: Tue, 1 Sep 2026 19:39:49 +0700
Subject: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info

The kvmppc_gsm_refresh_info() function incorrectly checks for the
presence of the fill_info callback instead of refresh_info.

This can lead to:
- NULL pointer dereference if refresh_info is NULL but fill_info is present
- EINVAL return if refresh_info is present but fill_info is NULL

Fix this by checking the correct callback.

Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers=
")
Signed-off-by: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
---
arch/powerpc/kvm/guest-state-buffer.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest=
-state-buffer.c
index 42843eca6727..aeb586ba4523 100644
--- a/arch/powerpc/kvm/guest-state-buffer.c
+++ b/arch/powerpc/kvm/guest-state-buffer.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
=C2=A0=C2=A0=C2=A0 struct kvmppc_gs_buff *gsb)
{
-=09if (!gsm->ops->fill_info)
+=09if (!gsm->ops->refresh_info)
return -EINVAL;
=C2=A0
return gsm->ops->refresh_info(gsm, gsb);
--=C2=A0
2.54.0
