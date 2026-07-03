Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E613546EA;
	Fri,  3 Jul 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056212; cv=none; b=DZy5xIyUPkQDKZtQcJXVP2zo4t9QQB1jz2d2d8365rDgGZz5L5ZwzmYCetoduecVLnkNO3Ry9vCymJ+oBUQsf/0FArItTEu7zD2HHs0MeU9SxAYL99cj1L4A2jsuiOBJP2k4Hu7/pC23ipk8jP8NyMbsOTNPeajlDmogMlbmGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056212; c=relaxed/simple;
	bh=/MegIW1B5Ph/z9o6j3vpknjkTxLfDtRU9G3pSaGuRSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIaOokew+Lr7EowGO8yKhVziiozlkh+UvkA5PDPwYcaQZ1hhrUquxxXwN3URv/O3vWWahfm3Z+33yQrj+/nER3XqwyWYZQiJJDQgKekZj1nzwcLfsGU+1661k+JLh+k7A67u4ecjiocZ2sQyk9a1yMh5XuR6TucjNEPIpk21wQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=QgYN2xsC reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="QgYN2xsC"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8T018373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:21:45 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6SxS8nVg3xnGkGVZhxJ3G3DZU8jRBJGr+RtAwqpbPdU=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783056106; v=1;
        b=QgYN2xsCcD3xLna//lkUa8qytMBfIhKXr/m/42WJSe23dJFVmFc8yRSPhU5iHenl
         OZo6Vl9ITdMn+SLCFkupO4MY+6oQg9Sc+S0X+8aLSXo7WIg1kHpXhlL2Yn2aOZfy
         J2zWXQsg9T7VQmRg9umr+me0rHqZD634DFtCKEzEJC/Ay3/lp+gOBphyJ2UTlY8F
         J/WMZcB5vh7ReK9I2StGrBSGxpXdNQRufr2y3gfv80If2ATSAD/9pC9f6QzyjXiD
         g9wjXkQXuVaCnS4h3iqzXu843CfMCjL5FURg/d0yNvmc8z06Ey+Az1PSbDIt89b8
         cOfEwrXXkc073eh77wa3Hw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:19:22 +0900
Subject: [PATCH v2 6/7] migration/ram: Fix ram_save_complete() return value
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ram-v2-6-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
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
        kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu.zevorn@gmail.com>, linux-edac@vger.kernel.org,
        qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=813;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=/MegIW1B5Ph/z9o6j3vpknjkTxLfDtRU9G3pSaGuRSs=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a72+M7k1Jrb37eu8tUIZdTP/fDhrsTP61dfWWHw81ej
 daUOadjOkpZGMS4GGTFFFlSinZza0TXfipMiG+BmcPKBDKEgYtTACbyWIGRYb35lvigt8rvKyvE
 9bymzzeZZbXGY4aDYdXFyOD70p3r2xn+6cSvM9obe2Pl/b7mtusfv7tx/UrJSzz61v/wL9mbbfb
 WLAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

ram_save_complete() and qemu_file_get_error_obj() are documented to
return negative values on error, but ram_save_complete() inverts the
sign of qemu_file_get_error_obj()'s return value. Remove the sign
inversion.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6bc7f705d31a..e1c191ec4383 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3431,7 +3431,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             int err = qemu_file_get_error_obj(f, &local_err);
 
             error_reportf_err(local_err, "Failed to write bitmap to file: ");
-            return -err;
+            return err;
         }
     }
 

-- 
2.54.0

