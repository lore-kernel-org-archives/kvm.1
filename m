Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859654;
	b=htrvMC0SQHg5rXZ1BbP6UFE+NCz/SpfBgCbNDHcBxU1kXOy+wCQslYGAT0oFh6dvI3lc
	 9no2dkEwjTda9Uw1QQZtZuw3gQy6L8BMVtASN/AmMY/9Xn6CQHdkZJnkSXrRZEyr9JLQO
	 Y1i6kRTtDU5hYSXVOOG80xBBHYxkRWRtAKCtV6afFwN4x/rj5j8L+i7j1IX8ycWXlM8b4
	 Olg8qq5B1w9Bg/EDWGvEzRnEqrL9adP9NBK22RC1zTjqRcL1h0RJw4NtZwRW0O1B1bmSF
	 SUmIKqZg2QdL3pYaGm2juOCPsVzW/NryMmuA2i70s9VXeT9pDY6KtrFAPmw09wu/Tpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859654;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cxP5oKTBqBRr5h+B+rnFKsncP8O8TdfFu/+MyP8ofrw=;
	b=SKeM4v272ZZMBZu4h63D5P9PTTVIL+eRPFBeVNvXlv7qkAZj44lsEQZpAwW06wWXCK2c
	 Rm3L/n3tQl3VEuV6EGsKC7NxdWm5+cx2HC8sGVlqueLjJVaT0PEyCiau/PMdr5oZbKEVD
	 QZ+8kNA8rA96WTHBYwBZdDgHPYkPh81s/383ZrT6D7A+3hcPB4d6kivQm0btIkrN11Pyz
	 5lGO3Apk5JQXCpLy8VPcrBOkOAfGax0vpWvK4EigPbCBC/qUB1XunQrbuLCDd7NGZAhpa
	 ayVh1pCbE0Ha92Uz8N5HDjVlI6tvFzbtpdkrxsMoimXGaCvy5T1xKNo6rCfhwnt+NJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iNGH4xwT;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768A606A31A
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6768A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iNGH4xwT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792859648; bh=cxP5oKTBqBRr5h+B+rnFKsncP8O8TdfFu/+MyP8ofrw=;
	h=From:To:Cc:Subject:Date;
	b=iNGH4xwTYlL63SDFjC5bgTZ7wa1mpdUrBgU9Dvo4sgX6+grMdjH4DQpJ47u3AqVcf
	 0m4lavQrnNOU9SP/O0hFQj7GaELW96BFDZmT+Cl4H/SbSXU+8DtARrZ7IkEiGBWZBp
	 JOfN+BJH8HsWqUAXyvcqbCSZ1UoQssp1RhOtMpeY=
Received: from [127.0.0.1] ([2409:8d5c:c30:3b3:dfb:e67e:fa31:2357])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 88631457; Sun, 25 Oct 2026 00:34:06 +0800
X-QQ-mid: xmsmtpt1792859646tsx6awf4f
Message-ID: <tencent_293D1F71F29317D2FD1758BA4419D205A606@qq.com>
X-QQ-XMAILINFO: OZMlMiGBv3y9sewMKs6VyGqtA3fLK09G177aCqLALVX0DtKWWIg5mS+nvD41w3
	 nUkUEKY/4Ubj0xj6NqX2NrjpV69JpArOp1ezKcH2bgnwD4bdjBFh8JO6LodCDIsF2xQV+o+p556Y
	 cCfnryeFwYztL5Mix+XBPFXFfoRaznYrb3hwSX2Rtn08nSKlOuArtL+g9gwynx8iTSFprokBrPYV
	 hJ4N45EUtSIAyF7A0OvLb8Q7THmyVF/SFNOIqobyMGJJGH6PQWJ388JIH9SplnU+UR0tCM3F7rw8
	 0zCcK/uphZ4aBZ44VO51zcaxpx4Ul/xrtL3ItsM6HUDFJLkobhJzpx6g5hx4CoDCAiJvzdPNX+1i
	 lXdz00lsFsKbrLexpO5a9TK6TlVpLmiYbLCdWItl7dyiFqLZPrZqpZhkkHABUHt6YmnyK64g8gq7
	 iU1zb7i9RqGpAWZY4sXnjFKaYOnYs8oftwdW+GlVFbFkJjIHKi+Mfeq/tyqhVRHXlgSAHw+Nt1ne
	 EfQD/siX47NSnCA6MfaNGo+E0O57dtbkcjMVGNyJTp9ttB2flWjvs4vEICnpEZrmUzUDrEpVUYck
	 dTEsNw4NveRXu+uB5zkTwOze51BqeT1SyuyXakDa3esRCbdea+ra2J5Wcotc30LdyOKfGii/mvw4
	 V/ihXcTduAQ55ufGqbM5mJob17JvvLN0QD5hEI3UOOkQUD7p7nVJHwhr0+vLE+NiywL4ClpB+vld
	 Q3BO7jvQ6K2K/HF4f+u6iaVdKfY0P5YCNS3tx8q0qVXjhSUTrFKBSbWdAVg/5zoqduN7scLtbcEk
	 2d55vWwYKhKNz1NzJ+jRP7bZwUWOW7c2ctE4z9l64zHdXqmzmks+wZNSIKOzFzFnRbh4erG/yHD2
	 X61Z5iB0CGCjWv+GamWSolER7uUOyk2PixTZ6+Zp+WAYptK1R7Gusb+GEZqBhhJjcaahlmYoGCJJ
	 NzGMMirm5Q4VXcVfhKybVr+oroeQXt6FDpKbkv4SCPdYGioGIeln7GWu8Y3LWmYlauFQVdQxky10
	 AG+0Xt/kfJlIScHGSJmMn1JLlBoANKOFNsEsDlhg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hang Nan <2122295973@qq.com>
To: kvm@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>
Subject: [PATCH] KVM: coalesced_mmio: reject zone sizes that don't fit in an int
Date: Sun, 25 Oct 2026 00:29:51 +0800
X-OQ-MSGID: <1792859391.770388.v1@qq.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kvm_vm_ioctl_register_coalesced_mmio() validates @zone->pio but not
@zone->size.  The u32 size is handed to kvm_io_bus_register_dev() as an
"int len", so any size >= 0x80000000 silently becomes negative.

coalesced_mmio_in_range() bails out immediately for len < 0, so such a
zone never matches its own range:

  - coalesced MMIO writes for the zone are no longer coalesced and are
    forwarded to userspace instead;
  - KVM_UNREGISTER_COALESCED_MMIO returns 0 but does not remove the zone,
    because the unregister path uses coalesced_mmio_in_range() for matching
    too, leaving the kvm_io_device permanently registered;
  - the leaked device occupies a slot on the MMIO/PIO bus.  After
    NR_IOBUS_DEVS - 1 (998) such zones every further
    kvm_io_bus_register_dev() on that bus fails with -ENOSPC, including
    ioeventfds and valid coalesced zones, effectively killing the VM's
    device model until the VM is destroyed.

A negative len additionally breaks the sorted-interval invariant used by
kvm_io_bus_cmp(), which computes the end of an interval as "addr + len".

ioeventfd rejects lengths outside {0, 1, 2, 4, 8}, so the same ioctl
family cannot be abused this way; coalesced MMIO has no equivalent check.

Reject the ioctl with -EINVAL instead.  The check has never existed
(git log -S 'INT_MAX' -- virt/kvm/coalesced_mmio.c is empty), so there is
no Fixes: tag; this is not a regression.

Reproducer, unprivileged on /dev/kvm (x86_64, v7.3-rc):

  - KVM_CREATE_VM
  - KVM_REGISTER_COALESCED_MMIO { addr = 0x1000, size = 0x80000000,
                                  pio = 0 }            -> 0 (accepted)
  - KVM_UNREGISTER_COALESCED_MMIO { same }             -> 0 (zone stays)
  - repeat 998 times, then register a valid zone       -> -ENOSPC

Signed-off-by: Hang Nan <2122295973@qq.com>

A PoC plus the serial log from a KASAN kernel built from
v7.3-11778-g5b0764a53235 is available on request (it is ~150 lines of
static C that only uses /dev/kvm).

---
 virt/kvm/coalesced_mmio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 000000000000..000000000000 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -14,6 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/slab.h>
 #include <linux/kvm.h>
+#include <linux/limits.h>
 
 #ifndef __KVM_NO_MMIO
 
@@ -130,6 +131,10 @@
 	if (zone->pio != 1 && zone->pio != 0)
 		return -EINVAL;
 
+	/* kvm_io_bus_register_dev() takes an int, don't let the u32 wrap */
+	if (zone->size > INT_MAX)
+		return -EINVAL;
+
 	dev = kzalloc_obj(struct kvm_coalesced_mmio_dev, GFP_KERNEL_ACCOUNT);
 	if (!dev)
 		return -ENOMEM;

