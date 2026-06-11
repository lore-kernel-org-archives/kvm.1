Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC13451C6
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162618; cv=none; b=Whg03Dc42IAookdTYhx9lQeWHjZUMIWZYvDFMKZMbj6qESLX8wzBTHwlBtXe1wqeSY0mbv2Fm5FeQmCOiO9Lp6BAqAXvu4pTP8J7p4glri4L6gvYOQXHaJ9A6aWRmg3V+aQDqrrFtAMFAGt7BoB9J/jx6MkmLPyrcWEHCXlcMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162618; c=relaxed/simple;
	bh=zun5J46n07yrxt8B36zgDHuFJ7LctWerMZAfkBTFbZY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QoOsNvH2VLAKst60P1gfhuZGsIk0G8j3t4CZOJ+W6wN+sxVxoOmqmgQ7Wi2cFcPvo+0XDLYjClJmKLy+kwXXXi9EjC+Siv+3p44+Ab+E7pesoociysFbOLKZ9G0H5GRSFxV9cy0xcChk97rM05E4h4akue0GHeH1iioE9J4T7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=eHspIBBt reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="eHspIBBt"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B6ZnFK023462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 15:35:59 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QJRQbh4Vp7+ROWhKqqXXYujUryc5YKkBTrxDxJHDvqY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1781159759; v=1;
        b=eHspIBBtwcgbSb6qp4mFggZ9NmQnM1/Bt048VjpXL3aIj0cK2NHVpH6pq4c+8nkZ
         s27CvY79bzlAODvZlIOFs1nRvVQZbJ51eBETpuUDXcPV6uUBmmorAo95S4fKH+0b
         WNjhDpSII2MbOwq787S/1TnhvcpuCgwPmZZPavuJcyivKI/9vxEOCC5MjnNpSRy4
         4V6dUbinian5Tbes8j/dVajWCex00JrFI4qNdhcpD+v+TDrF2HkkmFKnnkeQNA6N
         YQFrpx2ouUmbid9XBPEtb8uHJy3z2u/XaPTYG5+ibKibIRh/eVKYUwsoAa42NEOH
         Z5Lg4sb8DMqywAs3pAq1zw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
Date: Thu, 11 Jun 2026 15:35:47 +0900
Message-Id: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDINQtSszVTUlOTTM0STMwMExLUgKqLChKTcusAJsSHQvhF5cmZaUml4C
 0KtXWAgANeVcsZwAAAA==
X-Change-ID: 20260606-ram-dcef14f001fb
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Reinoud Zandijk <reinoud@netbsd.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alex Williamson <alex@shazbot.org>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=zun5J46n07yrxt8B36zgDHuFJ7LctWerMZAfkBTFbZY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ZWuGfKzD9vOYVL4ipWy9itqcwTiokNrqh2ehM8MUZ4m
 smqqeUdpSwMYlwMsmKKLClFu7k1oms/FSbEt8DMYWUCGcLAxSkAE8k+y8gwZc3B3ct1/WcWTd07
 aaNy4ievT+H7Kv/XMjqrq52XFjvbzPA/58Ld0607F4p1H9xUFJxx4kv93lu7rZZVJTlV7Zq4aoE
 VCwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH] system/physmem: Assert migration invariants")

ram_mig_ram_block_resized() already aborts migration when migratable RAM
is resized. Extend the same handling to other unsupported changes to the
migratable RAMBlock set, such as removing a migratable RAMBlock or
changing a RAMBlock's migratable state.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (3):
      system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
      system/physmem: Notify RAMBlock migratable and idstr changes
      migration/ram: Abort on unsupported migratable RAM changes

 include/migration/misc.h    |   2 +-
 include/system/ramlist.h    |  24 ++++++---
 block/block-ram-registrar.c |   8 +--
 hw/core/numa.c              |  54 ++++++++++++++++---
 hw/xen/xen-mapcache.c       |   6 +--
 migration/ram.c             | 125 ++++++++++++++++++++++++++++++++++++--------
 system/physmem.c            |  16 ++++--
 target/i386/nvmm/nvmm-all.c |   4 +-
 target/i386/sev.c           |   8 +--
 util/vfio-helpers.c         |   7 +--
 10 files changed, 194 insertions(+), 60 deletions(-)
---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260606-ram-dcef14f001fb

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

