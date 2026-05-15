Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D032D0F5
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778813736; cv=none; b=iXA/HxQUJXc8xvwJiz736KXWTzlFhT+x4YP/aWiAjDHhHCXIYuZLuTVN54eaKVkbsExpfW5E0iXk20aM+Cz1gCmdIbEP056bbY538DinPWEH+8JziKk05Jt16kTxYcy615hunJkMGynob9IJjhL4H03jIeld9iBk/j+6HcMyVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778813736; c=relaxed/simple;
	bh=iFKY4is2sOAKEefqIoZtMX9V3+lGIsfzA3clOPG9d04=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CcnRH44AUjSwxCZjVwIk98NPw11OoLfurLFWXDshAvakxl7uWAkouSIJI+QuVqFBYxSGPeScrUKuDAILtGwY+b7cZCpMEHscvKN04hB9jEsHYOokt9fQ8fl5Uv0+pZwvvr+iuzlHOpC4+gpV4uP6oMs5FZpRWUS2sUCvRcK+i/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fy8EEs58; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fy8EEs58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778813734; x=1810349734;
  h=date:from:to:cc:subject:message-id;
  bh=iFKY4is2sOAKEefqIoZtMX9V3+lGIsfzA3clOPG9d04=;
  b=Fy8EEs58U+OjTqXjAuI+txCPCmv/uSgJCQt9wi5QHaioWRTWFJu+iTAE
   X2XqwQl+mh4eINnTKGDvJFfZtNuUyxPx+G6/wXqQSbj+lKgPRgqvxuXf5
   qNz/TeNnlPzXPu7XciQGAZfLBiD4yx/CFbJXtpPfySnyA9wgxyBOdHhOn
   BHjKDXFyE3cxKuW/wK5WrQa3XdSkDXXW1Q3Uwmbq326TiToAAcl+8rW+H
   qfCFv65E0X7+wi+gw3v4z2atQyvNBAyuENqX/eCrQY/Dltf6JjOsVl/BY
   VhDlTp3mSFNaTgS+D/LrcWzk4g0klFnCC2abhaNQldy8TNJH/jRrWffA+
   Q==;
X-CSE-ConnectionGUID: OjnVx+E0SKegXGBH2CP81g==
X-CSE-MsgGUID: A0Heu+07TLqMtc1zr7g+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79724172"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79724172"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 19:55:33 -0700
X-CSE-ConnectionGUID: 7v0L/JFcQGGsxl9l73Nb7A==
X-CSE-MsgGUID: ycB4iTCUQ3iCOY1cadbdkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="268909770"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 May 2026 19:55:29 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNihU-000000000gT-1R4F;
	Fri, 15 May 2026 02:55:07 +0000
Date: Fri, 15 May 2026 10:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Farrah Chen <farrah.chen@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm:queue 15/24] arch/x86/kvm/vmx/vmcs12.c:56:9: sparse:
 sparse: cast truncates bits from constant value (901c9 becomes 1c9)
Message-ID: <202605151012.SKmItXMm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
head:   0d449443caabcfa7ba0c8ce4fd383d13819a681d
commit: 33ad4c7aab63a5c00752d1121f107dbc3e48d6ed [15/24] KVM: nVMX: Propagate the extended instruction info field
config: x86_64-randconfig-122-20260515 (https://download.01.org/0day-ci/archive/20260515/202605151012.SKmItXMm-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151012.SKmItXMm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151012.SKmItXMm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/vmx/vmcs12.c:15:9: sparse: sparse: cast truncates bits from constant value (20002 becomes 2)
   arch/x86/kvm/vmx/vmcs12.c:16:9: sparse: sparse: cast truncates bits from constant value (20082 becomes 82)
   arch/x86/kvm/vmx/vmcs12.c:17:9: sparse: sparse: cast truncates bits from constant value (20102 becomes 102)
   arch/x86/kvm/vmx/vmcs12.c:18:9: sparse: sparse: cast truncates bits from constant value (20182 becomes 182)
   arch/x86/kvm/vmx/vmcs12.c:19:9: sparse: sparse: cast truncates bits from constant value (20202 becomes 202)
   arch/x86/kvm/vmx/vmcs12.c:20:9: sparse: sparse: cast truncates bits from constant value (20282 becomes 282)
   arch/x86/kvm/vmx/vmcs12.c:21:9: sparse: sparse: cast truncates bits from constant value (20302 becomes 302)
   arch/x86/kvm/vmx/vmcs12.c:22:9: sparse: sparse: cast truncates bits from constant value (20382 becomes 382)
   arch/x86/kvm/vmx/vmcs12.c:23:9: sparse: sparse: cast truncates bits from constant value (20402 becomes 402)
   arch/x86/kvm/vmx/vmcs12.c:24:9: sparse: sparse: cast truncates bits from constant value (20482 becomes 482)
   arch/x86/kvm/vmx/vmcs12.c:25:9: sparse: sparse: cast truncates bits from constant value (30003 becomes 3)
   arch/x86/kvm/vmx/vmcs12.c:26:9: sparse: sparse: cast truncates bits from constant value (30083 becomes 83)
   arch/x86/kvm/vmx/vmcs12.c:27:9: sparse: sparse: cast truncates bits from constant value (30103 becomes 103)
   arch/x86/kvm/vmx/vmcs12.c:28:9: sparse: sparse: cast truncates bits from constant value (30183 becomes 183)
   arch/x86/kvm/vmx/vmcs12.c:29:9: sparse: sparse: cast truncates bits from constant value (30203 becomes 203)
   arch/x86/kvm/vmx/vmcs12.c:30:9: sparse: sparse: cast truncates bits from constant value (30283 becomes 283)
   arch/x86/kvm/vmx/vmcs12.c:31:9: sparse: sparse: cast truncates bits from constant value (30303 becomes 303)
   arch/x86/kvm/vmx/vmcs12.c:32:9: sparse: sparse: cast truncates bits from constant value (80008 becomes 8)
   arch/x86/kvm/vmx/vmcs12.c:32:9: sparse: sparse: cast truncates bits from constant value (80048 becomes 48)
   arch/x86/kvm/vmx/vmcs12.c:33:9: sparse: sparse: cast truncates bits from constant value (80088 becomes 88)
   arch/x86/kvm/vmx/vmcs12.c:33:9: sparse: sparse: cast truncates bits from constant value (800c8 becomes c8)
   arch/x86/kvm/vmx/vmcs12.c:34:9: sparse: sparse: cast truncates bits from constant value (80108 becomes 108)
   arch/x86/kvm/vmx/vmcs12.c:34:9: sparse: sparse: cast truncates bits from constant value (80148 becomes 148)
   arch/x86/kvm/vmx/vmcs12.c:35:9: sparse: sparse: cast truncates bits from constant value (80188 becomes 188)
   arch/x86/kvm/vmx/vmcs12.c:35:9: sparse: sparse: cast truncates bits from constant value (801c8 becomes 1c8)
   arch/x86/kvm/vmx/vmcs12.c:36:9: sparse: sparse: cast truncates bits from constant value (80208 becomes 208)
   arch/x86/kvm/vmx/vmcs12.c:36:9: sparse: sparse: cast truncates bits from constant value (80248 becomes 248)
   arch/x86/kvm/vmx/vmcs12.c:37:9: sparse: sparse: cast truncates bits from constant value (80288 becomes 288)
   arch/x86/kvm/vmx/vmcs12.c:37:9: sparse: sparse: cast truncates bits from constant value (802c8 becomes 2c8)
   arch/x86/kvm/vmx/vmcs12.c:38:9: sparse: sparse: cast truncates bits from constant value (80388 becomes 388)
   arch/x86/kvm/vmx/vmcs12.c:38:9: sparse: sparse: cast truncates bits from constant value (803c8 becomes 3c8)
   arch/x86/kvm/vmx/vmcs12.c:39:9: sparse: sparse: cast truncates bits from constant value (80408 becomes 408)
   arch/x86/kvm/vmx/vmcs12.c:39:9: sparse: sparse: cast truncates bits from constant value (80448 becomes 448)
   arch/x86/kvm/vmx/vmcs12.c:40:9: sparse: sparse: cast truncates bits from constant value (80c88 becomes c88)
   arch/x86/kvm/vmx/vmcs12.c:40:9: sparse: sparse: cast truncates bits from constant value (80cc8 becomes cc8)
   arch/x86/kvm/vmx/vmcs12.c:41:9: sparse: sparse: cast truncates bits from constant value (80488 becomes 488)
   arch/x86/kvm/vmx/vmcs12.c:41:9: sparse: sparse: cast truncates bits from constant value (804c8 becomes 4c8)
   arch/x86/kvm/vmx/vmcs12.c:42:9: sparse: sparse: cast truncates bits from constant value (80508 becomes 508)
   arch/x86/kvm/vmx/vmcs12.c:42:9: sparse: sparse: cast truncates bits from constant value (80548 becomes 548)
   arch/x86/kvm/vmx/vmcs12.c:43:9: sparse: sparse: cast truncates bits from constant value (80588 becomes 588)
   arch/x86/kvm/vmx/vmcs12.c:43:9: sparse: sparse: cast truncates bits from constant value (805c8 becomes 5c8)
   arch/x86/kvm/vmx/vmcs12.c:44:9: sparse: sparse: cast truncates bits from constant value (80608 becomes 608)
   arch/x86/kvm/vmx/vmcs12.c:44:9: sparse: sparse: cast truncates bits from constant value (80648 becomes 648)
   arch/x86/kvm/vmx/vmcs12.c:45:9: sparse: sparse: cast truncates bits from constant value (80688 becomes 688)
   arch/x86/kvm/vmx/vmcs12.c:45:9: sparse: sparse: cast truncates bits from constant value (806c8 becomes 6c8)
   arch/x86/kvm/vmx/vmcs12.c:46:9: sparse: sparse: cast truncates bits from constant value (80708 becomes 708)
   arch/x86/kvm/vmx/vmcs12.c:46:9: sparse: sparse: cast truncates bits from constant value (80748 becomes 748)
   arch/x86/kvm/vmx/vmcs12.c:47:9: sparse: sparse: cast truncates bits from constant value (80788 becomes 788)
   arch/x86/kvm/vmx/vmcs12.c:47:9: sparse: sparse: cast truncates bits from constant value (807c8 becomes 7c8)
   arch/x86/kvm/vmx/vmcs12.c:48:9: sparse: sparse: cast truncates bits from constant value (80808 becomes 808)
   arch/x86/kvm/vmx/vmcs12.c:48:9: sparse: sparse: cast truncates bits from constant value (80848 becomes 848)
   arch/x86/kvm/vmx/vmcs12.c:49:9: sparse: sparse: cast truncates bits from constant value (80888 becomes 888)
   arch/x86/kvm/vmx/vmcs12.c:49:9: sparse: sparse: cast truncates bits from constant value (808c8 becomes 8c8)
   arch/x86/kvm/vmx/vmcs12.c:50:9: sparse: sparse: cast truncates bits from constant value (80908 becomes 908)
   arch/x86/kvm/vmx/vmcs12.c:50:9: sparse: sparse: cast truncates bits from constant value (80948 becomes 948)
   arch/x86/kvm/vmx/vmcs12.c:51:9: sparse: sparse: cast truncates bits from constant value (80988 becomes 988)
   arch/x86/kvm/vmx/vmcs12.c:51:9: sparse: sparse: cast truncates bits from constant value (809c8 becomes 9c8)
   arch/x86/kvm/vmx/vmcs12.c:52:9: sparse: sparse: cast truncates bits from constant value (80a08 becomes a08)
   arch/x86/kvm/vmx/vmcs12.c:52:9: sparse: sparse: cast truncates bits from constant value (80a48 becomes a48)
   arch/x86/kvm/vmx/vmcs12.c:53:9: sparse: sparse: cast truncates bits from constant value (80b08 becomes b08)
   arch/x86/kvm/vmx/vmcs12.c:53:9: sparse: sparse: cast truncates bits from constant value (80b48 becomes b48)
   arch/x86/kvm/vmx/vmcs12.c:54:9: sparse: sparse: cast truncates bits from constant value (80b88 becomes b88)
   arch/x86/kvm/vmx/vmcs12.c:54:9: sparse: sparse: cast truncates bits from constant value (80bc8 becomes bc8)
   arch/x86/kvm/vmx/vmcs12.c:55:9: sparse: sparse: cast truncates bits from constant value (90009 becomes 9)
   arch/x86/kvm/vmx/vmcs12.c:55:9: sparse: sparse: cast truncates bits from constant value (90049 becomes 49)
   arch/x86/kvm/vmx/vmcs12.c:56:9: sparse: sparse: cast truncates bits from constant value (90189 becomes 189)
>> arch/x86/kvm/vmx/vmcs12.c:56:9: sparse: sparse: cast truncates bits from constant value (901c9 becomes 1c9)
   arch/x86/kvm/vmx/vmcs12.c:57:9: sparse: sparse: cast truncates bits from constant value (a000a becomes a)
   arch/x86/kvm/vmx/vmcs12.c:57:9: sparse: sparse: cast truncates bits from constant value (a004a becomes 4a)
   arch/x86/kvm/vmx/vmcs12.c:58:9: sparse: sparse: cast truncates bits from constant value (a008a becomes 8a)
   arch/x86/kvm/vmx/vmcs12.c:58:9: sparse: sparse: cast truncates bits from constant value (a00ca becomes ca)
   arch/x86/kvm/vmx/vmcs12.c:59:9: sparse: sparse: cast truncates bits from constant value (a010a becomes 10a)
   arch/x86/kvm/vmx/vmcs12.c:59:9: sparse: sparse: cast truncates bits from constant value (a014a becomes 14a)
   arch/x86/kvm/vmx/vmcs12.c:60:9: sparse: sparse: cast truncates bits from constant value (a018a becomes 18a)
   arch/x86/kvm/vmx/vmcs12.c:60:9: sparse: sparse: cast truncates bits from constant value (a01ca becomes 1ca)
   arch/x86/kvm/vmx/vmcs12.c:61:9: sparse: sparse: cast truncates bits from constant value (a020a becomes 20a)
   arch/x86/kvm/vmx/vmcs12.c:61:9: sparse: sparse: cast truncates bits from constant value (a024a becomes 24a)
   arch/x86/kvm/vmx/vmcs12.c:62:9: sparse: sparse: cast truncates bits from constant value (a028a becomes 28a)
   arch/x86/kvm/vmx/vmcs12.c:62:9: sparse: sparse: cast truncates bits from constant value (a02ca becomes 2ca)
   arch/x86/kvm/vmx/vmcs12.c:63:9: sparse: sparse: cast truncates bits from constant value (a030a becomes 30a)
   arch/x86/kvm/vmx/vmcs12.c:63:9: sparse: sparse: cast truncates bits from constant value (a034a becomes 34a)
   arch/x86/kvm/vmx/vmcs12.c:64:9: sparse: sparse: cast truncates bits from constant value (a038a becomes 38a)
   arch/x86/kvm/vmx/vmcs12.c:64:9: sparse: sparse: cast truncates bits from constant value (a03ca becomes 3ca)
   arch/x86/kvm/vmx/vmcs12.c:65:9: sparse: sparse: cast truncates bits from constant value (a040a becomes 40a)
   arch/x86/kvm/vmx/vmcs12.c:65:9: sparse: sparse: cast truncates bits from constant value (a044a becomes 44a)
   arch/x86/kvm/vmx/vmcs12.c:66:9: sparse: sparse: cast truncates bits from constant value (a048a becomes 48a)
   arch/x86/kvm/vmx/vmcs12.c:66:9: sparse: sparse: cast truncates bits from constant value (a04ca becomes 4ca)
   arch/x86/kvm/vmx/vmcs12.c:67:9: sparse: sparse: cast truncates bits from constant value (b000b becomes b)
   arch/x86/kvm/vmx/vmcs12.c:67:9: sparse: sparse: cast truncates bits from constant value (b004b becomes 4b)
   arch/x86/kvm/vmx/vmcs12.c:68:9: sparse: sparse: cast truncates bits from constant value (b008b becomes 8b)
   arch/x86/kvm/vmx/vmcs12.c:68:9: sparse: sparse: cast truncates bits from constant value (b00cb becomes cb)
   arch/x86/kvm/vmx/vmcs12.c:69:9: sparse: sparse: cast truncates bits from constant value (b010b becomes 10b)
   arch/x86/kvm/vmx/vmcs12.c:69:9: sparse: sparse: cast truncates bits from constant value (b014b becomes 14b)
   arch/x86/kvm/vmx/vmcs12.c:70:9: sparse: sparse: cast truncates bits from constant value (100010 becomes 10)
   arch/x86/kvm/vmx/vmcs12.c:71:9: sparse: sparse: cast truncates bits from constant value (100090 becomes 90)
   arch/x86/kvm/vmx/vmcs12.c:72:9: sparse: sparse: cast truncates bits from constant value (100110 becomes 110)
   arch/x86/kvm/vmx/vmcs12.c:73:9: sparse: sparse: cast truncates bits from constant value (100190 becomes 190)
   arch/x86/kvm/vmx/vmcs12.c:74:9: sparse: sparse: cast truncates bits from constant value (100210 becomes 210)
   arch/x86/kvm/vmx/vmcs12.c:75:9: sparse: sparse: cast truncates bits from constant value (100290 becomes 290)
   arch/x86/kvm/vmx/vmcs12.c:76:9: sparse: sparse: cast truncates bits from constant value (100310 becomes 310)
   arch/x86/kvm/vmx/vmcs12.c:77:9: sparse: sparse: cast truncates bits from constant value (100390 becomes 390)
   arch/x86/kvm/vmx/vmcs12.c:78:9: sparse: sparse: cast truncates bits from constant value (100410 becomes 410)
   arch/x86/kvm/vmx/vmcs12.c:79:9: sparse: sparse: cast truncates bits from constant value (100490 becomes 490)
   arch/x86/kvm/vmx/vmcs12.c:80:9: sparse: sparse: cast truncates bits from constant value (100510 becomes 510)
   arch/x86/kvm/vmx/vmcs12.c:81:9: sparse: sparse: cast truncates bits from constant value (100590 becomes 590)
   arch/x86/kvm/vmx/vmcs12.c:82:9: sparse: sparse: cast truncates bits from constant value (100610 becomes 610)
   arch/x86/kvm/vmx/vmcs12.c:83:9: sparse: sparse: cast truncates bits from constant value (100690 becomes 690)
   arch/x86/kvm/vmx/vmcs12.c:84:9: sparse: sparse: cast truncates bits from constant value (100710 becomes 710)
   arch/x86/kvm/vmx/vmcs12.c:85:9: sparse: sparse: cast truncates bits from constant value (100790 becomes 790)
   arch/x86/kvm/vmx/vmcs12.c:86:9: sparse: sparse: cast truncates bits from constant value (110011 becomes 11)
   arch/x86/kvm/vmx/vmcs12.c:87:9: sparse: sparse: cast truncates bits from constant value (110091 becomes 91)
   arch/x86/kvm/vmx/vmcs12.c:88:9: sparse: sparse: cast truncates bits from constant value (110111 becomes 111)
   arch/x86/kvm/vmx/vmcs12.c:89:9: sparse: sparse: cast truncates bits from constant value (110191 becomes 191)
   arch/x86/kvm/vmx/vmcs12.c:90:9: sparse: sparse: cast truncates bits from constant value (110211 becomes 211)
   arch/x86/kvm/vmx/vmcs12.c:91:9: sparse: sparse: cast truncates bits from constant value (110291 becomes 291)
   arch/x86/kvm/vmx/vmcs12.c:92:9: sparse: sparse: cast truncates bits from constant value (110311 becomes 311)
   arch/x86/kvm/vmx/vmcs12.c:93:9: sparse: sparse: cast truncates bits from constant value (110391 becomes 391)
   arch/x86/kvm/vmx/vmcs12.c:94:9: sparse: sparse: cast truncates bits from constant value (120012 becomes 12)
   arch/x86/kvm/vmx/vmcs12.c:95:9: sparse: sparse: cast truncates bits from constant value (120092 becomes 92)
   arch/x86/kvm/vmx/vmcs12.c:96:9: sparse: sparse: cast truncates bits from constant value (120112 becomes 112)
   arch/x86/kvm/vmx/vmcs12.c:97:9: sparse: sparse: cast truncates bits from constant value (120192 becomes 192)
   arch/x86/kvm/vmx/vmcs12.c:98:9: sparse: sparse: cast truncates bits from constant value (120212 becomes 212)
   arch/x86/kvm/vmx/vmcs12.c:99:9: sparse: sparse: cast truncates bits from constant value (120292 becomes 292)
   arch/x86/kvm/vmx/vmcs12.c:100:9: sparse: sparse: cast truncates bits from constant value (120312 becomes 312)
   arch/x86/kvm/vmx/vmcs12.c:101:9: sparse: sparse: cast truncates bits from constant value (120392 becomes 392)
   arch/x86/kvm/vmx/vmcs12.c:102:9: sparse: sparse: cast truncates bits from constant value (120412 becomes 412)
   arch/x86/kvm/vmx/vmcs12.c:103:9: sparse: sparse: cast truncates bits from constant value (120492 becomes 492)
   arch/x86/kvm/vmx/vmcs12.c:104:9: sparse: sparse: cast truncates bits from constant value (120512 becomes 512)
   arch/x86/kvm/vmx/vmcs12.c:105:9: sparse: sparse: cast truncates bits from constant value (120592 becomes 592)
   arch/x86/kvm/vmx/vmcs12.c:106:9: sparse: sparse: cast truncates bits from constant value (120612 becomes 612)
   arch/x86/kvm/vmx/vmcs12.c:107:9: sparse: sparse: cast truncates bits from constant value (120692 becomes 692)
   arch/x86/kvm/vmx/vmcs12.c:108:9: sparse: sparse: cast truncates bits from constant value (120712 becomes 712)
   arch/x86/kvm/vmx/vmcs12.c:109:9: sparse: sparse: cast truncates bits from constant value (120792 becomes 792)
   arch/x86/kvm/vmx/vmcs12.c:110:9: sparse: sparse: cast truncates bits from constant value (120812 becomes 812)
   arch/x86/kvm/vmx/vmcs12.c:111:9: sparse: sparse: cast truncates bits from constant value (120892 becomes 892)
   arch/x86/kvm/vmx/vmcs12.c:112:9: sparse: sparse: cast truncates bits from constant value (120912 becomes 912)
   arch/x86/kvm/vmx/vmcs12.c:113:9: sparse: sparse: cast truncates bits from constant value (120992 becomes 992)
   arch/x86/kvm/vmx/vmcs12.c:114:9: sparse: sparse: cast truncates bits from constant value (120a92 becomes a92)
   arch/x86/kvm/vmx/vmcs12.c:115:9: sparse: sparse: cast truncates bits from constant value (130013 becomes 13)
   arch/x86/kvm/vmx/vmcs12.c:116:9: sparse: sparse: cast truncates bits from constant value (120b92 becomes b92)
   arch/x86/kvm/vmx/vmcs12.c:117:9: sparse: sparse: cast truncates bits from constant value (180018 becomes 18)
   arch/x86/kvm/vmx/vmcs12.c:118:9: sparse: sparse: cast truncates bits from constant value (180098 becomes 98)
   arch/x86/kvm/vmx/vmcs12.c:119:9: sparse: sparse: cast truncates bits from constant value (180118 becomes 118)
   arch/x86/kvm/vmx/vmcs12.c:120:9: sparse: sparse: cast truncates bits from constant value (180198 becomes 198)
   arch/x86/kvm/vmx/vmcs12.c:121:9: sparse: sparse: cast truncates bits from constant value (190019 becomes 19)
   arch/x86/kvm/vmx/vmcs12.c:122:9: sparse: sparse: cast truncates bits from constant value (190299 becomes 299)
   arch/x86/kvm/vmx/vmcs12.c:123:9: sparse: sparse: cast truncates bits from constant value (1a001a becomes 1a)
   arch/x86/kvm/vmx/vmcs12.c:124:9: sparse: sparse: cast truncates bits from constant value (1a009a becomes 9a)
   arch/x86/kvm/vmx/vmcs12.c:125:9: sparse: sparse: cast truncates bits from constant value (1a011a becomes 11a)
   arch/x86/kvm/vmx/vmcs12.c:126:9: sparse: sparse: cast truncates bits from constant value (1a019a becomes 19a)
   arch/x86/kvm/vmx/vmcs12.c:127:9: sparse: sparse: cast truncates bits from constant value (1a021a becomes 21a)
   arch/x86/kvm/vmx/vmcs12.c:128:9: sparse: sparse: cast truncates bits from constant value (1a029a becomes 29a)
   arch/x86/kvm/vmx/vmcs12.c:129:9: sparse: sparse: cast truncates bits from constant value (1a031a becomes 31a)
   arch/x86/kvm/vmx/vmcs12.c:130:9: sparse: sparse: cast truncates bits from constant value (1a039a becomes 39a)
   arch/x86/kvm/vmx/vmcs12.c:131:9: sparse: sparse: cast truncates bits from constant value (1a041a becomes 41a)
   arch/x86/kvm/vmx/vmcs12.c:132:9: sparse: sparse: cast truncates bits from constant value (1a049a becomes 49a)
   arch/x86/kvm/vmx/vmcs12.c:133:9: sparse: sparse: cast truncates bits from constant value (1a051a becomes 51a)
   arch/x86/kvm/vmx/vmcs12.c:134:9: sparse: sparse: cast truncates bits from constant value (1a059a becomes 59a)
   arch/x86/kvm/vmx/vmcs12.c:135:9: sparse: sparse: cast truncates bits from constant value (1a061a becomes 61a)
   arch/x86/kvm/vmx/vmcs12.c:136:9: sparse: sparse: cast truncates bits from constant value (1a069a becomes 69a)
   arch/x86/kvm/vmx/vmcs12.c:137:9: sparse: sparse: cast truncates bits from constant value (1a071a becomes 71a)
   arch/x86/kvm/vmx/vmcs12.c:138:9: sparse: sparse: cast truncates bits from constant value (1a079a becomes 79a)
   arch/x86/kvm/vmx/vmcs12.c:139:9: sparse: sparse: cast truncates bits from constant value (1a081a becomes 81a)
   arch/x86/kvm/vmx/vmcs12.c:140:9: sparse: sparse: cast truncates bits from constant value (1a089a becomes 89a)
   arch/x86/kvm/vmx/vmcs12.c:141:9: sparse: sparse: cast truncates bits from constant value (1a091a becomes 91a)
   arch/x86/kvm/vmx/vmcs12.c:142:9: sparse: sparse: cast truncates bits from constant value (1a099a becomes 99a)
   arch/x86/kvm/vmx/vmcs12.c:143:9: sparse: sparse: cast truncates bits from constant value (1a0a1a becomes a1a)

vim +56 arch/x86/kvm/vmx/vmcs12.c

     5	
     6	#define VMCS12_OFFSET(x) offsetof(struct vmcs12, x)
     7	#define FIELD(number, name)	[ENC_TO_VMCS12_IDX(number)] = VMCS12_OFFSET(name)
     8	#define FIELD64(number, name)						\
     9		FIELD(number, name),						\
    10		[ENC_TO_VMCS12_IDX(number##_HIGH)] = VMCS12_OFFSET(name) + sizeof(u32)
    11	
    12	static const u16 kvm_supported_vmcs12_field_offsets[] __initconst = {
    13		FIELD(VIRTUAL_PROCESSOR_ID, virtual_processor_id),
    14		FIELD(POSTED_INTR_NV, posted_intr_nv),
    15		FIELD(GUEST_ES_SELECTOR, guest_es_selector),
    16		FIELD(GUEST_CS_SELECTOR, guest_cs_selector),
    17		FIELD(GUEST_SS_SELECTOR, guest_ss_selector),
    18		FIELD(GUEST_DS_SELECTOR, guest_ds_selector),
    19		FIELD(GUEST_FS_SELECTOR, guest_fs_selector),
    20		FIELD(GUEST_GS_SELECTOR, guest_gs_selector),
    21		FIELD(GUEST_LDTR_SELECTOR, guest_ldtr_selector),
    22		FIELD(GUEST_TR_SELECTOR, guest_tr_selector),
    23		FIELD(GUEST_INTR_STATUS, guest_intr_status),
    24		FIELD(GUEST_PML_INDEX, guest_pml_index),
    25		FIELD(HOST_ES_SELECTOR, host_es_selector),
    26		FIELD(HOST_CS_SELECTOR, host_cs_selector),
    27		FIELD(HOST_SS_SELECTOR, host_ss_selector),
    28		FIELD(HOST_DS_SELECTOR, host_ds_selector),
    29		FIELD(HOST_FS_SELECTOR, host_fs_selector),
    30		FIELD(HOST_GS_SELECTOR, host_gs_selector),
    31		FIELD(HOST_TR_SELECTOR, host_tr_selector),
    32		FIELD64(IO_BITMAP_A, io_bitmap_a),
    33		FIELD64(IO_BITMAP_B, io_bitmap_b),
    34		FIELD64(MSR_BITMAP, msr_bitmap),
    35		FIELD64(VM_EXIT_MSR_STORE_ADDR, vm_exit_msr_store_addr),
    36		FIELD64(VM_EXIT_MSR_LOAD_ADDR, vm_exit_msr_load_addr),
    37		FIELD64(VM_ENTRY_MSR_LOAD_ADDR, vm_entry_msr_load_addr),
    38		FIELD64(PML_ADDRESS, pml_address),
    39		FIELD64(TSC_OFFSET, tsc_offset),
    40		FIELD64(TSC_MULTIPLIER, tsc_multiplier),
    41		FIELD64(VIRTUAL_APIC_PAGE_ADDR, virtual_apic_page_addr),
    42		FIELD64(APIC_ACCESS_ADDR, apic_access_addr),
    43		FIELD64(POSTED_INTR_DESC_ADDR, posted_intr_desc_addr),
    44		FIELD64(VM_FUNCTION_CONTROL, vm_function_control),
    45		FIELD64(EPT_POINTER, ept_pointer),
    46		FIELD64(EOI_EXIT_BITMAP0, eoi_exit_bitmap0),
    47		FIELD64(EOI_EXIT_BITMAP1, eoi_exit_bitmap1),
    48		FIELD64(EOI_EXIT_BITMAP2, eoi_exit_bitmap2),
    49		FIELD64(EOI_EXIT_BITMAP3, eoi_exit_bitmap3),
    50		FIELD64(EPTP_LIST_ADDRESS, eptp_list_address),
    51		FIELD64(VMREAD_BITMAP, vmread_bitmap),
    52		FIELD64(VMWRITE_BITMAP, vmwrite_bitmap),
    53		FIELD64(XSS_EXIT_BITMAP, xss_exit_bitmap),
    54		FIELD64(ENCLS_EXITING_BITMAP, encls_exiting_bitmap),
    55		FIELD64(GUEST_PHYSICAL_ADDRESS, guest_physical_address),
  > 56		FIELD64(EXTENDED_INSTRUCTION_INFO, extended_instruction_info),
    57		FIELD64(VMCS_LINK_POINTER, vmcs_link_pointer),
    58		FIELD64(GUEST_IA32_DEBUGCTL, guest_ia32_debugctl),
    59		FIELD64(GUEST_IA32_PAT, guest_ia32_pat),
    60		FIELD64(GUEST_IA32_EFER, guest_ia32_efer),
    61		FIELD64(GUEST_IA32_PERF_GLOBAL_CTRL, guest_ia32_perf_global_ctrl),
    62		FIELD64(GUEST_PDPTR0, guest_pdptr0),
    63		FIELD64(GUEST_PDPTR1, guest_pdptr1),
    64		FIELD64(GUEST_PDPTR2, guest_pdptr2),
    65		FIELD64(GUEST_PDPTR3, guest_pdptr3),
    66		FIELD64(GUEST_BNDCFGS, guest_bndcfgs),
    67		FIELD64(HOST_IA32_PAT, host_ia32_pat),
    68		FIELD64(HOST_IA32_EFER, host_ia32_efer),
    69		FIELD64(HOST_IA32_PERF_GLOBAL_CTRL, host_ia32_perf_global_ctrl),
    70		FIELD(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control),
    71		FIELD(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control),
    72		FIELD(EXCEPTION_BITMAP, exception_bitmap),
    73		FIELD(PAGE_FAULT_ERROR_CODE_MASK, page_fault_error_code_mask),
    74		FIELD(PAGE_FAULT_ERROR_CODE_MATCH, page_fault_error_code_match),
    75		FIELD(CR3_TARGET_COUNT, cr3_target_count),
    76		FIELD(VM_EXIT_CONTROLS, vm_exit_controls),
    77		FIELD(VM_EXIT_MSR_STORE_COUNT, vm_exit_msr_store_count),
    78		FIELD(VM_EXIT_MSR_LOAD_COUNT, vm_exit_msr_load_count),
    79		FIELD(VM_ENTRY_CONTROLS, vm_entry_controls),
    80		FIELD(VM_ENTRY_MSR_LOAD_COUNT, vm_entry_msr_load_count),
    81		FIELD(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field),
    82		FIELD(VM_ENTRY_EXCEPTION_ERROR_CODE, vm_entry_exception_error_code),
    83		FIELD(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len),
    84		FIELD(TPR_THRESHOLD, tpr_threshold),
    85		FIELD(SECONDARY_VM_EXEC_CONTROL, secondary_vm_exec_control),
    86		FIELD(VM_INSTRUCTION_ERROR, vm_instruction_error),
    87		FIELD(VM_EXIT_REASON, vm_exit_reason),
    88		FIELD(VM_EXIT_INTR_INFO, vm_exit_intr_info),
    89		FIELD(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code),
    90		FIELD(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field),
    91		FIELD(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code),
    92		FIELD(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len),
    93		FIELD(VMX_INSTRUCTION_INFO, vmx_instruction_info),
    94		FIELD(GUEST_ES_LIMIT, guest_es_limit),
    95		FIELD(GUEST_CS_LIMIT, guest_cs_limit),
    96		FIELD(GUEST_SS_LIMIT, guest_ss_limit),
    97		FIELD(GUEST_DS_LIMIT, guest_ds_limit),
    98		FIELD(GUEST_FS_LIMIT, guest_fs_limit),
    99		FIELD(GUEST_GS_LIMIT, guest_gs_limit),
   100		FIELD(GUEST_LDTR_LIMIT, guest_ldtr_limit),
   101		FIELD(GUEST_TR_LIMIT, guest_tr_limit),
   102		FIELD(GUEST_GDTR_LIMIT, guest_gdtr_limit),
   103		FIELD(GUEST_IDTR_LIMIT, guest_idtr_limit),
   104		FIELD(GUEST_ES_AR_BYTES, guest_es_ar_bytes),
   105		FIELD(GUEST_CS_AR_BYTES, guest_cs_ar_bytes),
   106		FIELD(GUEST_SS_AR_BYTES, guest_ss_ar_bytes),
   107		FIELD(GUEST_DS_AR_BYTES, guest_ds_ar_bytes),
   108		FIELD(GUEST_FS_AR_BYTES, guest_fs_ar_bytes),
   109		FIELD(GUEST_GS_AR_BYTES, guest_gs_ar_bytes),
   110		FIELD(GUEST_LDTR_AR_BYTES, guest_ldtr_ar_bytes),
   111		FIELD(GUEST_TR_AR_BYTES, guest_tr_ar_bytes),
   112		FIELD(GUEST_INTERRUPTIBILITY_INFO, guest_interruptibility_info),
   113		FIELD(GUEST_ACTIVITY_STATE, guest_activity_state),
   114		FIELD(GUEST_SYSENTER_CS, guest_sysenter_cs),
   115		FIELD(HOST_IA32_SYSENTER_CS, host_ia32_sysenter_cs),
   116		FIELD(VMX_PREEMPTION_TIMER_VALUE, vmx_preemption_timer_value),
   117		FIELD(CR0_GUEST_HOST_MASK, cr0_guest_host_mask),
   118		FIELD(CR4_GUEST_HOST_MASK, cr4_guest_host_mask),
   119		FIELD(CR0_READ_SHADOW, cr0_read_shadow),
   120		FIELD(CR4_READ_SHADOW, cr4_read_shadow),
   121		FIELD(EXIT_QUALIFICATION, exit_qualification),
   122		FIELD(GUEST_LINEAR_ADDRESS, guest_linear_address),
   123		FIELD(GUEST_CR0, guest_cr0),
   124		FIELD(GUEST_CR3, guest_cr3),
   125		FIELD(GUEST_CR4, guest_cr4),
   126		FIELD(GUEST_ES_BASE, guest_es_base),
   127		FIELD(GUEST_CS_BASE, guest_cs_base),
   128		FIELD(GUEST_SS_BASE, guest_ss_base),
   129		FIELD(GUEST_DS_BASE, guest_ds_base),
   130		FIELD(GUEST_FS_BASE, guest_fs_base),
   131		FIELD(GUEST_GS_BASE, guest_gs_base),
   132		FIELD(GUEST_LDTR_BASE, guest_ldtr_base),
   133		FIELD(GUEST_TR_BASE, guest_tr_base),
   134		FIELD(GUEST_GDTR_BASE, guest_gdtr_base),
   135		FIELD(GUEST_IDTR_BASE, guest_idtr_base),
   136		FIELD(GUEST_DR7, guest_dr7),
   137		FIELD(GUEST_RSP, guest_rsp),
   138		FIELD(GUEST_RIP, guest_rip),
   139		FIELD(GUEST_RFLAGS, guest_rflags),
   140		FIELD(GUEST_PENDING_DBG_EXCEPTIONS, guest_pending_dbg_exceptions),
   141		FIELD(GUEST_SYSENTER_ESP, guest_sysenter_esp),
   142		FIELD(GUEST_SYSENTER_EIP, guest_sysenter_eip),
   143		FIELD(GUEST_S_CET, guest_s_cet),
   144		FIELD(GUEST_SSP, guest_ssp),
   145		FIELD(GUEST_INTR_SSP_TABLE, guest_ssp_tbl),
   146		FIELD(HOST_CR0, host_cr0),
   147		FIELD(HOST_CR3, host_cr3),
   148		FIELD(HOST_CR4, host_cr4),
   149		FIELD(HOST_FS_BASE, host_fs_base),
   150		FIELD(HOST_GS_BASE, host_gs_base),
   151		FIELD(HOST_TR_BASE, host_tr_base),
   152		FIELD(HOST_GDTR_BASE, host_gdtr_base),
   153		FIELD(HOST_IDTR_BASE, host_idtr_base),
   154		FIELD(HOST_IA32_SYSENTER_ESP, host_ia32_sysenter_esp),
   155		FIELD(HOST_IA32_SYSENTER_EIP, host_ia32_sysenter_eip),
   156		FIELD(HOST_RSP, host_rsp),
   157		FIELD(HOST_RIP, host_rip),
   158		FIELD(HOST_S_CET, host_s_cet),
   159		FIELD(HOST_SSP, host_ssp),
   160		FIELD(HOST_INTR_SSP_TABLE, host_ssp_tbl),
   161	};
   162	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
