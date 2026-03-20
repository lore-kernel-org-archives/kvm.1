Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3433D6E6
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774069875; cv=none; b=jSrQUdfq3CWtPq1HhQhNXyFuMk/ldjHffBmdO8O0L2nr+Qzt5lNV79QdUwtHpXIi7DOp0tTi9uAI1DKkg3TwDdysHePZAzmEztunfHQiiDutWdMq/qMkYVX1bo8twbK6qiCFXJMJ0MG1asXoqwOdlf/I52S7pYSR0rskGJr+MAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774069875; c=relaxed/simple;
	bh=qVwlCu1WIXntn26q1kvsy4ns7XCLQh3LUnFd91zRr48=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=N+1cvW0vrAstbfbWH+/6sFGXOWVzarsuR/OBHrJGFzLIWGl3X33fGWdV0dyiVYpvpa7VpFRA6AFDylttRjgc6sDh9MbR2LWc6r8qn10iuDA5NlUJrexkjwpyYW3yxEcI9FNoL1/dE0u+68YWf4yhcmPL6jjezXiFOn+K9BnmxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLe7OxhB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLe7OxhB"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7412b07f22so1590112a12.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774069873; x=1774674673; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
        b=OLe7OxhBzFwMPIltVknpGrXU9DN7TZFVr3dJDvog+FEKXYmG+fHE2bFbgoZCuFCuw2
         0eJIPaT+MwpkQBDn5zFbJSu9h2HQa0J7qzB1ZsadIyJ8Bau/FOCcW7WsotI/JazwbOwC
         Liacvp0OhfIMtoPN1/bsxA1AetNrt12rxXcHel3gly35cWWZocy2wqHD4vswnXxER4SK
         TKXch+jKp5VDm59qDJg8ua+0OqFS8JstiSXF1Pwy5A8Zcue6JB5wdTTc5OSZOMyh9cCw
         BYWG4YhdCWoTZ4G1qzRqr0iGs0BgB00W7fAJFkySqVoTIt3dNWFPgkagFcG568A1/AfF
         xj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774069873; x=1774674673;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
        b=WiAbR2cv5X4f70y1dqQV4cnEqUSoJ+lLCdDwvWM6YH8CaG2kKzta/KnmA/oVpHbYBE
         eTMTJuSwqEFLZ+bfwnZpYQy8HkB/TDvzpMmqohiVwSwiZRQ1vz/tj9dmuwyOeF2BeS8y
         4hOfPKd22a9nsvLdYYH62L4oElDzLb6ORJCPw8UN1EsmASH1PaLrbcfGqakeow0k3K4i
         RtuiXJb77qd2ZqkShqTO0HUASl3bXzquMVOdUdRG1vpRsYtG34kbyXYPFz50YZKfrusz
         i1pq+kAIn8RYMmTFSzi/+nIpbXETolesQHpuBdkfSqrxswPPgBh2qXXYa3bRSJB8tPpd
         jNHA==
X-Forwarded-Encrypted: i=1; AJvYcCU2by6N0rs6zpF1xuNKwGSeXaghCM7vGK+hfD39zFn5DY6IcAMfVF9cjB/jvYPQA9i73WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJIZLPJpeb/q+kf9c8P5i4oUbrAyA3mVjRl+5t93FYz91YI4k
	Kaqkn78j53/A+gENmw6B2V7OpWF0y1uM51J5n8MqJv1U0dae5kCsJ6sY
X-Gm-Gg: ATEYQzxluqwsJJ+JmZD1azPEGYh8IOtmuvFv9YskarhhNBOJO+v63oU4d7E2qr2izc5
	bZoOJa2W/v/ktah97SJpe9P1XQFLIykuVD8sBEVbQ0U856eipqezdeBfHhlOhQGlvSdbTP9AN6R
	G4tEsphCo/U1bAUMqOYRoRN/kBQqX6guXS9VOgeQZ2M1ruF4h0SDjfqbYF7rmPT1/bJdEj4FRts
	lO9Dn1GTezKP0u3FHh9qliTuvIOW537JTCETFmBy/085yhR1ZR3f4996nAs9CKIrvnPpQYMK5k7
	662+VBILD8Va8bClCWUuw6WCFI90HM82oJ2Gw3GZFWbSd9ky9o9DRDNZh21/4x8/k66ExsgVy9w
	t/yFUp7bDwQXF/2tqw9QbZ7FUkuuRBRpXsMPt/8tGOFH+N8lWecmbpwm5HSaMpDSXOi3Gi7bfe1
	Cs9cMceHdYi60+116DfrFIAQ==
X-Received: by 2002:a05:6a21:4cca:b0:39b:9c3a:f54f with SMTP id adf61e73a8af0-39bb25e7511mr8216718637.32.1774069873215;
        Fri, 20 Mar 2026 22:11:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a939af0sm2729778a12.16.2026.03.20.22.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:11:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change to return bool for ptep_test_and_clear_young()
In-Reply-To: <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:27:48 +0530
Message-ID: <ikarxctf.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Callers use ptep_test_and_clear_young() to clear the young flag and check
> whether it was set. Change the return type to bool to make the intention
> clearer.
>

Right I checked all callers of ptep_test_and_clear_young(). I agree, we
only need bool here. 

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  8 ++++----
>  arch/arm64/mm/contpte.c                      |  4 ++--
>  arch/microblaze/include/asm/pgtable.h        |  2 +-
>  arch/parisc/include/asm/pgtable.h            |  6 +++---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ++--
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
>  arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++--

I looked at it because of powerpc changes, but ended up looking into all
call sites anyways. So overall it LGTM (and I agree that we can remove
the unnecessary externs from function declarations)

With that please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
