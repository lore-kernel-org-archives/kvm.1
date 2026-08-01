Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D511392C56
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596025; cv=none; b=YoPKbsuWqkwrgd7cidop1UG6QzO4dcEEPchgqVIZWTQe7Z7k92fivK9GSdJEDsHi49ACN4JJ2jMDwHnU9HAL74K5xssmQNyj0HxXIhK/K/dom3ZMEIARSM8KUjCmoYB0m7Q9BinV8Zz6WQ+g0KeSItvLMXoXaQqbt9eEceuZDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596025; c=relaxed/simple;
	bh=yeqwqLWTn3kKWQV1l1n+i1uCJ3pN+wNcLIE036bFtIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLyuKaj4/pikewIklwu+gGCnYPwgPZK4QUcATSTV5YVwx56D5NR4F3vPFlmqkSsSgwafZSq81Oy7mFu+skCfJJ/c+MPI9boBObVSnWPkDH0l6X33Fee19/iJxCl0HTQ8xSZ4x9T8mAJGKUWjp0nKWzeq2oIW0rMplzFqSXWY+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3ir/s9P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3ir/s9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785596022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O/d/WsORIy9Di/BYkKYsyN+xpsQqeswHxZvHgZ23Mk=;
	b=i3ir/s9PImBw/eS47v0zpFYtq5WEk1aZvkLqJMCo2tGSTBH7jAxl6UjV+T6z/C+Q/lPxZh
	uaqtGGP5y5eOpoWsIvZPb9AYZSqd1iNIVV9+9wPywpzMCivBv2PBL82QWwaim+b5F4LbrB
	9fFRnQh5wskV90tECPAH+pnXxR57XY8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Gv5ZGnJBMDizVPNHYCgZsw-1; Sat,
 01 Aug 2026 10:53:40 -0400
X-MC-Unique: Gv5ZGnJBMDizVPNHYCgZsw-1
X-Mimecast-MFC-AGG-ID: Gv5ZGnJBMDizVPNHYCgZsw_1785596019
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CDAF19560A2;
	Sat,  1 Aug 2026 14:53:39 +0000 (UTC)
Received: from alougovs-mac.redhat.com (unknown [10.44.48.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 268F31956089;
	Sat,  1 Aug 2026 14:53:35 +0000 (UTC)
From: Alexander Lougovski <alougovs@redhat.com>
To: tycho@kernel.org
Cc: Alexander Lougovski <alougovs@redhat.com>,
	bp@alien8.de,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	thomas.lendacky@amd.com,
	vkuznets@redhat.com
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled
Date: Sat,  1 Aug 2026 16:53:32 +0200
Message-ID: <20260801145333.25241-1-alougovs@redhat.com>
In-Reply-To: <amt5YCuJhzpxHMK7@tycho.pizza>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jul 30, 2026 at 10:26:46AM -0600, Tycho Andersen wrote:

Hi Tycho, 

> Ok, makes sense. I found enough hardware yesterday to run ~35 VMs with
> a bit of memory pressure, so smaller is better for me.
I run it on a 2 socket single host with 128c/256t and 1.5TB RAM - not really pushing memory limits. So cannot comment if actually memory pressure is required.


> When you say "200 VM hours", I guess that's an average? Or do you find
> they need to run that long to see the fault?
Most of the times I would say I see the first BSOD on 42VM fleet within first 10-11 hours after experiment's start -> equovalent of 400-500 VM-hours. However if running over a course of several days, average time drops to more like 200-300 VM-hours per crash. Also sometimes they batch up. E.g. a few within 1-2 hours and then nothing for a day.


> Also, how are you detecting the BSOD? I'm just waiting for ssh to stop
> responding and screen capping the VNC, but maybe there's a better way.

Yeah that's a bit if pain. SSH is not always reliable, since I'm somewhat thrashing VMs (also storage under the sql pressure get's somewhat slow with latency spikes up to several seconds in VM) - timeout aren't that uncommon . So what appeared to work better is using SAC over serial.

Here is a script I use. As a bonus it also keeps a track of VMs' uptimes.


---------8<----------------
 
#!/usr/bin/env bash
LOG=/tmp/serial-stress.log
UPTIME_LOG=/tmp/serial-uptimes.log
CYCLE=0
while true; do
    CYCLE=$((CYCLE + 1))
    TS=$(date '+%Y-%m-%d %H:%M:%S')
    OK=0
    FAIL=""
    UPTIMES=""
    for N in $(seq 1 42); do
        UP=$( (sleep 0.2; printf "\r\nid\r\n"; sleep 1.2) | timeout 3 socat UNIX-CONNECT:/tmp/serial-${N}.sock STDIO 2>/dev/null | grep -o "Time since last reboot:.*" | sed 's/Time since last reboot: //' | tr -d '\r')
        if [ -z "$UP" ]; then
            FAIL="$FAIL vm-$N"
        else
            OK=$((OK+1))
            UPTIMES="$UPTIMES vm-$N=$UP"
        fi
    done
    if [ -n "$FAIL" ]; then
        echo "[$TS] cycle=$CYCLE ${OK}/42 FAIL:$FAIL" >> $LOG
    else
        echo "[$TS] cycle=$CYCLE 42/42 OK" >> $LOG
    fi
    if [ $((CYCLE % 10)) -eq 0 ]; then
        echo "[$TS] cycle=$CYCLE$UPTIMES" >> $UPTIME_LOG
    fi
    sleep 5
done
--------8<---------------

most of the time you if vm is listed in the output (I personally redirect it to stress-serial.log file and watch it) as FAILED for 2-3 consequative rounds  - it is a BSOD, then your agent can take a screenshot and confirm.

> Thanks for this as well, I only had hv-tlbflush=on, I'll go ahead and
> adapt my command line to yours.
Not 100% if others do matter, but that's how I run it. Another thing to notice, I'm somehow more successful reproducing BSODs when storage path is stressed. When I stress networking path I get BSOD waaaaay more seldome, and cannot ATM state that these BSODs have the same root cause even thought they also indicate signs of memory corruption/stale cache. 

Hope it helps,
Let me know if you were able to hit a BSOD. With 35 VMs I would expect to see it within first 15 hours or so.


Thanks,
Al

