Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703691D0DEE
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850909; cv=none; b=X7neLj2K+U9THEp26U6wow5z6efWEhHLWsKRmAL1+vii15xNtokOLvD9sbcL4LALmRS5ncds5zGJJdtXSBD5VwMrC9qRK60hBLYnRXBwFjLu093mGORwNRFghH/d2iemn8gpaOMcxYqjapM1mzmB3PsMTSBe0At+2sM0xcIGV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850909; c=relaxed/simple;
	bh=WIFvRSp9xXtL1X+LbyxOJFnGjbOxI0gBiuD3jdR3weI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGSssj174L1/n8tLJh6mcUErrDg5ujJ/e6v+dNp9Zchv5rkTDvnWIrF0Q2kcCpnmnQwUaH2BjqMWzRgbo9Q5cWJgmkLB4c7eqVaCTQi3GjFpLkdVXmncq2yhh1A8ogNqv74dh3/xztAUYuyUMCT8kCIfhrTVEAj623ARjpxRw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dP7iVzz7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dP7iVzz7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf906b007so1500696f8f.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850907; x=1776455707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hmYqwWSqPmJMgJvimCb5gTwLjtaQvrO8BVqR+We6PI=;
        b=dP7iVzz7NWD2CzdXPQ1sFAwf8kEVDFd11zPt7/MVy3k2kntghcW83Ohj6Q+I5i6pQU
         NSGI+Vwc7/DDDNflSK7ux5862iEgSaMgsDriuZ3hkU1zED3N8xU31/LXA7+vxFhf7Vt2
         OHujcz7dIO/pR+8jYj33P8T3w/aZVIZXIoyDr/fIXjTKtZgzyQZvRglRiVB6UO4AZUzq
         Mw/LeYk+zbRVUW3q9STL7PUxTajpXFQnoi/KGakRVFMMzCoci5zspCmJ+ZUzWtKWwg6h
         PfqMMMtMvnnPL9SMaBFCUuYJRVvORqee+VUjPe6hrBugUePs3VlCRZrCBR1LiNle0zoy
         4v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850907; x=1776455707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1hmYqwWSqPmJMgJvimCb5gTwLjtaQvrO8BVqR+We6PI=;
        b=gTBSXyY//5n4qcXRRPz0+UqE2QAKgZXK6TZh+IHgov2Mg3r3KmqTinhZwJrnZVTfxJ
         vzsgCC0rLh7hDq4XXSJvsDg+CwFQby0LFNlWJ/2ZGRT15meDYsDKfnEpYpLYRHvGx0ik
         kTsvGIkaAHq6yqJZX2+kzeVK/K/6jP6Q2Au43t61mdu+ZtxJMzWuGJsPjepo2FVQQBVn
         WcEeo100/TR+z3aG++qi1HAYqNey3kxSMhbFnCOoDiCNHW+MXtwRILe7XPYBFxF58aUH
         aH6KKTytI7JrF38PqjQ1cs//yskCjQzQJ0D4WbiFIhVz5bhHQwWu850+txcXJQsA424Z
         +xdA==
X-Forwarded-Encrypted: i=1; AJvYcCXdGLh1ksYk4PvLTvf0OgGygR72OVlZaGPuIZ89Ihd7V4N+rZaoTTlWluNoUQF8V+kQ53Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9NMWjUqUvn3OMFhlWp8aC2XkSVVVEVewsbiO9jYCOALPlQwO
	o0vqKR+CbHqWKFLx0/bMfy0/d4LxCncUTrPDqoeKhHhwhvq32OuKlRm3NAcQdjdVl4s=
X-Gm-Gg: AeBDiet/BbHiNutvNphlzjNwroqXzs99AbQjIPgIb575mvGcjBy7ZQXl4nveiKa8r9s
	zWaTUrGj42g5WV/0CXBxe1a6z563nY4tFRS/ctea5Tt96xRAPHKODvQEVsOiI+c1/so9e3kt8rS
	j7I+fccOGYmiMx6wKUsZDwla3trJwBvpck5pENbgDukp0gqO56twjG2aZH+eE9s8MqZZWZ6p9vZ
	d192+giA2oetgcWQqmZ6gQ1FfknImzs1Wlm4S77lFY9MUOAKr1maswtPAC0QFKvRvt2fjgDBkOt
	iTUyj4qBhxXOAyRAnxw/HW0IsPKWVWW0xt2iQ91yMv2ex78AUnhxQQBm5bzMb1gaxIieaCcfBCq
	tasCT92dzlnEfVb5QCJs2u8IBVRW+ACofMc0UMOKUKLjRP0vcp8yxVJbyQ471AoKuzgDfd/nQ9u
	l/+cNNG1YGQwy73HCkfHtY5stmrOhjvu5DceU/LxL86wyAcf7q+6/AM4jxykvBi/RFuNDOqDl+
X-Received: by 2002:a05:6000:184b:b0:43c:ea2d:9c7a with SMTP id ffacd0b85a97d-43d642cc2dfmr7403832f8f.49.1775850906890;
        Fri, 10 Apr 2026 12:55:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e468d0sm9671181f8f.18.2026.04.10.12.55.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 14/27] monitor/meson: Use SPICE with migration HMP commands
Date: Fri, 10 Apr 2026 21:53:08 +0200
Message-ID: <20260410195323.17937-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When moving code around in commit 27be86351ec ("migration: Move
the QMP command from monitor/ to migration/") we forgot to update
the meson rule about SPICE pkg-config flags.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/meson.build | 2 +-
 monitor/meson.build   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index c9f0f5f9f21..e583822dec6 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -23,7 +23,6 @@ system_ss.add(files(
   'fd.c',
   'file.c',
   'global_state.c',
-  'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
   'multifd-device-state.c',
@@ -37,6 +36,7 @@ system_ss.add(files(
   'socket.c',
   'tls.c',
 ), gnutls, zlib)
+system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
diff --git a/monitor/meson.build b/monitor/meson.build
index 2647100e04c..585251804e4 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -5,8 +5,8 @@ system_ss.add(files(
   'hmp-cmds.c',
   'hmp.c',
   'qemu-config-qmp.c',
+  'qmp-cmds.c',
 ))
-system_ss.add([spice_headers, files('qmp-cmds.c')])
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c'), spice])
+                if_true: [files('hmp-target.c')])
-- 
2.53.0

