Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B93E2AD8
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370407; cv=none; b=eABIiTOeyUG0Did54RAsLdZVgejdX7nhGVrNqX/nitx9sK7SdkLfDbXq0QsGVRc/0yZnS2aHjxq51Cb3HIvae+hlc4wGXFX/dUizaBN1uSv759ok5rhAPrJp1Gtgkus8h7EPzRgY8dXi16H1oc7yadOaHF+CwS4Ydnu5Kl9owgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370407; c=relaxed/simple;
	bh=8bizRyk7GW6qyySQlYQ0DTymr3ExxhETstQq8otWOfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YaJj2Uo0RP4wbS+bTn00viCJQVCQO/eFOMSjyiM+rnqoorwydA7byzkqU6wZ554XKGsXGDlMhx0+P28Uu+6oJ4vc+AGzViUaoVPJJWrliykaqViZcgBfcwmJW+wtl3YHxIIJkGE9nCUykGV/Y0EmuFkP5rcT1blqayztpAjbllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a43d32fa9fso2489376b6e.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 07:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370405; x=1786975205;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TnCTV/GbL5slz2CFw0qSIvIG2ErknLlvPUHDbT/xDwY=;
        b=SmwMWN2W+TbqVpFVZLv5TwPm2gpENVWeOg+m6B4AM/HtafXQy9tsV+7cSx7+NUr/J0
         ooNd32dOYgGsR/YsFR/evBxLaswv9hL+ht0oNIwRLbO6bRtYUROZAsBewUewjAa7elOA
         KWh7ay7lQVegUs94EB25ioOUaX5oAYUKiYt/88EwPav/YQA87Ilem0QYsa958lUF3oZ2
         bIMVlgriaPAwxlmzhVMHFBJvH9EoT5rkauYoPuWacBgt3VHm8RoKDHrevcnS0VjDpZfb
         Twq8RTFvNXS3dQOHfa/LTMb6nyfKDjRegIZD3R+Ghx/tGFjY/dg8N/0mTlEQQ8z28mU5
         8dZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpl12PIzM8JnvxB1qm7byMpiao4yQx/tDg06m7pV/H4q4ybPS4DHtMg9N+WuBqmRtCweJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFeGOoBMcPImkRiXs++v/2KWLNAMOWk35fD/+ctxpnIIi8nKs
	jD2p8uy5Sh9+vJh/CyeN6ALMLhYWkCaLQVfopR4n0cx62+NQcjkloQUQVxY/gctW04d0H0wxMWQ
	/Ha/g5jknmSvSiqW9zKXm0t2CfFL8eYLNPZ2w4qyPbGbK9X4liioUescIF9s=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13cd:b0:4a4:ed9a:e793 with SMTP id
 5614622812f47-4b1ab9775a5mr10352729b6e.16.1786370404770; Mon, 10 Aug 2026
 07:00:04 -0700 (PDT)
Date: Mon, 10 Aug 2026 07:00:04 -0700
In-Reply-To: <7e9fc104fec7d2776590edb95a94a7afbf109c57.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a79d964.9c11d2ce.289b96.00ee.GAE@google.com>
Subject: Re: [syzbot] [kvm-x86?] [kvm?] WARNING: locking bug in kvm_xen_set_evtchn_fast
From: syzbot <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@kernel.org, suryasaimadhu369@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.infradead.org/users/dwmw2/linux.git/xen-srcu-fixed: failed to run ["git" "-c" "core.hooksPath=/dev/null" "fetch" "--force" "73b08201ab8ba1d188f45210a65f33cb30e5efaf" "xen-srcu-fixed"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       git://git.infradead.org/users/dwmw2/linux.git xen-srcu-fixed
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
compiler:       

Note: no patches were applied.
