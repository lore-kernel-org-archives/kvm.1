Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6B3B5F50
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956365; cv=none; b=GM1665ymOJcVLvgjrk9zzazK5dKIiU91BtSNsaSXD5nHxRwN+4T/gKB0YoaxHsIXnpaCAgPBfFA8UDjtxDURbN6mf9tfhBcRV7BRFDaH8m0nju5/xzsJz8ig0S+NlzAi9nJcWrenaC1gtjiLplJuo71NZKkxytKfgkphZ+HPPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956365; c=relaxed/simple;
	bh=tr+yS/U2zVZ/vKOCaD/s2oKAtYA2wSCZis/PydBoLMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+8tLI/ckdAYY6ZaWOilA7oV8CfIMhUXrnv+tKkOwmg1RmQlU3pZ2TBSC/8KNxPwOUEQnZ1W4KsjjAiXRi/Km91p/gRSJtmqog4huc7xanqA7kxR3C7kPpR+GF7wdB/d+J5R3K3jmC0s3qKY/pKmiS+pecimhnGoqFKbwPvqqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iUS5RBUf; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iUS5RBUf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786956359; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zuSCFvnjinY4nZAUd4Yu+OzZxTlTGJpWYsVssLnpzt0=;
	b=iUS5RBUf3KiLaohrDUiDwdtCDXzADxw7JCg/EZlWBAuRI7K5lZPITLDon1L3kwpic8KSZP52zlS0Aqc/TW8/2I5xlha1PYJDO9fNH9KWlw/80qZoK3rJan9aS+QLEITNdujYfCyhF0dHkbVWjKZHFT/+1R+Z4y/qVQ35OaKvSZc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X94smxS_1786956358;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X94smxS_1786956358 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 16:45:59 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	will@kernel.org
Cc: yaoyuan0329os@gmail.com,
	yaoyuan@linux.alibaba.com
Subject: [PATCH kvmtool 0/1] Don't empty CFLAGS in Makefile for static building
Date: Mon, 17 Aug 2026 16:45:33 +0800
Message-Id: <20260817084534.92780-1-yaoyuan@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't set the CFLAGS to empty in Makefile for passing more
CFLAGS options from environment variable, e.g -static for
native static building.

One use case of static buidling is using kvmtool for
pre-silicon validation on emulation system, such system has
limited or even no IO part and run w/ small solo ramdisk as
linux userspace instead of full Linux distribution, and run
in slow speed. Thus the self-contained kvmtool static
building is good choice in performance and size for testing
on such system.

The static building is verified on arm64 host:

CFLAGS=-static make -j32
...
LINK     lkvm
LN       vm

$ldd ./lkvm
        not a dynamic executable

The funciton is verified w/ below command, boot arm64 guest
to serial successfully:

cmdline=(
	ignore_loglevel
	earlycon=uart8250,mmio,0x1000000,115200n8
	console=uart8250,mmio,0x1000000,115200n8
	nokaslr
	selinux=0
	audit=0
	root=/dev/vda3
)

./lkvm run \
	   --name test_kvmtool \
	   -c 4 -m 1G \
	   --nodefaults \
	   --irqchip gicv3-its \
	   --console serial \
	   --virtio-transport pci \
	   --disk /path/to/the/disk/image
	   --kernel /path/to/the/arm64/boot/image
	   --param "${cmdline[*]}"


Yao Yuan (1):
  Makefile: Don't set -CFLAGS := in Makefile

 Makefile | 1 -
 1 file changed, 1 deletion(-)

--
2.43.5
