Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B008CA45
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610187; cv=none; b=NljBUPndh2+K4CvVpfFu7ka5/gcjdHLGEZhN8xGvRjSh/rmAam4A486h/km46aAlDJQHYk+m9UCnKhq+9Km92u5kkdDimzG4hWIerlx6z75jkBjvL3aByqobzTMZr+D8Tl8vjSZOBvo7vQstGBsWvfvVSXLf9CDSqxrNefBT7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610187; c=relaxed/simple;
	bh=2GA6tNZGkY1fy1D9P0+IiQbKdmjzwkeyHUYVGzpSPpU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=guCHZ5SCaKU68Z40pXzRW8Br47KweNmTeXeknbuuAsYUCugY+ki77sNm/EQd8EnlfXUksJJfWoVrYsIkSrM6OqjiFIwc1ka6wKVFA5D32ud23jN4c8PQLHBDAz1IAnUZRa+DO6czTwVEzv7TRrVIXuR8YKWVYh1C0kCa1383p3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matthewpenney.net; spf=pass smtp.mailfrom=matthewpenney.net; dkim=pass (2048-bit key) header.d=matthewpenney.net header.i=@matthewpenney.net header.b=AYiwC0E8; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matthewpenney.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthewpenney.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthewpenney.net header.i=@matthewpenney.net header.b="AYiwC0E8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
	s=protonmail; t=1775610173; x=1775869373;
	bh=H3u1e6oqrvjOVue/AzgRE2wOemZMtQFe4II1WfBXrww=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AYiwC0E8Ua31xK/RfacfzYUctL3QqJvOXd+KF23ebGWEBmA0K1+CPvkQb6BDxdMGS
	 pjiHyuoDqYfcLRmh2h/yWAzAl4EFEO6ebpGqIdNw+EjCI5fwRRwnWm+79G8y1Rkc5S
	 bXvXgsDQsWhtMYCJXy+6rjPY0LtNmYu2SoMiStzpOgf28r3J8TpCctquO8YBdKyHVZ
	 Z4X4bK+wO5aaW/f8hWYkOlCw+UCZVe4dMnCr8qN7tCL64Bt+ww/ByEtNl/dF1t4MVd
	 EmXrbTgKlxCJvBseaQCK+K4YNNge1eiUEMXbuniyr9XaEzgGj5qhd23DG9VmVhi1hJ
	 QnFWWxMCsjivg==
Date: Wed, 08 Apr 2026 01:02:49 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, kvm@vger.kernel.org
Subject: [PATCH 6/8] target/i386/kvm: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-7-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 02f22ade2439bebbfcb019f0bd7f951675313f34
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace g_source_remove() and explicit watch id check with
g_clear_handle_id().

This simplifies the code and ensures consistent handling of GSource IDs,
since g_clear_handle_id() checks for a non-zero ID before calling the
cleanup function.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 target/i386/kvm/tdx-quote-generator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-qu=
ote-generator.c
index dee8334b27..ab10986efa 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -75,9 +75,7 @@ static void tdx_generate_quote_cleanup(TdxGenerateQuoteTa=
sk *task)
 {
     timer_del(&task->timer);
=20
-    if (task->watch) {
-        g_source_remove(task->watch);
-    }
+    g_clear_handle_id(&task->watch, g_source_remove);
     qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
     object_unref(OBJECT(task->sioc));
=20
--=20
2.53.0


