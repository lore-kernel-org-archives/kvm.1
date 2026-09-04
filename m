Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC8254AFF
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483095; cv=none; b=ZR5AkMDc12pJYaDoWdIwNhV/CuwNf+fyBo4nt4Px069fCueCNh4rGd2VueeIAxNBaeZVVwLpzYR8JypNxmkS/YJ9NefIUtAmwLvAaRFoUzq5fUUz0NsG3l/z6SJo4SyHfIy84zB1iGWu/VOV2UponPhBvlpNzV5wPwdm5h7Vf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483095; c=relaxed/simple;
	bh=bjUTNXGidzIZEyrz+v2s9x6tmUWypnFmcnFdiMziEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLOL/mH+T28J788vQeGXidiqS/W9BahCOiAjrrXx+o2Zuyf3PalOslmQrQF6DXgxNpVXEDIn14opczUMkrmFDBBXddjdjJTqcAyWD/OiqD6FSHvkpzNX57jv9VWiBIwJOWNKulgyfLR/4QXF6lRADTP4XLcxN0Z8WN8duvlH3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=m+GQcQ02; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="m+GQcQ02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1788483088;
	bh=NHVvGl/JeJlfVlH9Bp7+T+8OJJZfuThp2XTH+28fS0o=;
	h=From:Subject:Date:Message-ID;
	b=m+GQcQ02VAv01GDoTUmnQEl6t/McUOP/gopTOELH+IoyZCGMI8mI4pfOu/5tF26PN
	 L6L7Tve9oFBMEAryqqbQ6xtZUyCl3QLm0Tx9aEhZYOayJXe26Zz/khYDMVPoc6b1Xn
	 ISb1ljWeCkwrwEEuAjLobPJpY2xlo347jXITWqxA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6A9A1608000075FD; Fri, 4 Sep 2026 08:51:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4064374456609
X-SMAIL-UIID: A72629F7F0964B8792FFCC7D669E7526-20260904-085123-1
From: Hillf Danton <hdanton@sina.com>
To: Sean Christopherson <seanjc@google.com>
Cc: syzbot <syzbot+6895ff73d58c59e653ba@syzkaller.appspotmail.com>,
	david@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] INFO: task hung in kvm_gmem_release
Date: Fri,  4 Sep 2026 08:51:09 +0800
Message-ID: <20260904005111.2069-1-hdanton@sina.com>
In-Reply-To: <20260901073343.2002-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 15:33:42 +0800 Hillf Danton wrote:
>On Mon, 31 Aug 2026 08:15:44 -0700 Sean Christopherson wrote:
>>
>> Marking this invalid, as I'm 99.9% certain guest_memfd is an innocent bystander.
>> CPU1 is stuck on an IN instruction (the actual port I/O), and there are a handful
>> of identical failures in random subsystems that pop up a few times a month[*].
>> My guess is the host side of the serial port is going out to lunch intermittently.
>> 
>> [*] https://lore.kernel.org/all/?q=%22io_serial_in%22%20syzkaller
>> 
>> #syz invalid
>>
>The 0.1% uncertainty hints this invalid mark is NOT true or at least earlier
>than thought, because a) the IN instruction is not kvm specific [11] and b) the
>i2c hang [11] is i2c specific [12].
>
>[11] Subject: [syzbot] [i2c?] [usb?] INFO: task hung in em28xx_i2c_unregister
>https://lore.kernel.org/lkml/6a95ef74.764875ec.b345.0003.GAE@google.com/
>
>[12] Subject: [syzbot] [i2c?] [usb?] INFO: task hung in em28xx_i2c_unregister
>https://lore.kernel.org/lkml/6a9676c7.764875ec.b345.0007.GAE@google.com/
>
>That said, extra evidence is needed to prove that the serial port is going out
>to lunch on the host side.
>
For archive purpose, the sleeper with nfsd_mutex held [15] explains the nfsd_mutex
waiter [16], another case that defies the lunch guess.

[15] Subject: [syzbot] [nfs?] INFO: task hung in nfsd4_cld_tracking_init
https://lore.kernel.org/lkml/6a99f6f0.2e567484.299ffc.000c.GAE@google.com/

[16] Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nrthreads
https://lore.kernel.org/lkml/6a98a3c5.27a413cd.1e878c.0010.GAE@google.com/
