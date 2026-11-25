Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586748;
	b=HdJo/azKj9ogh9vaMWIIvgOiphuMaOEMn4eYDabtgQuCgi4sSzPm9fFYY9mcq8e8lLFk
	 D4m/vpN0MNmO/an/NH1KEXcZkcQr2OHnTqlsgoU0Zbz6ckcftNF5rihoAXfNR6JVgTtSz
	 4lna9Pn7674FKHxElGyHS0euY9VN0ym94WqKVLfO+d1bsPueBIiA1SKcvPZ80sjhMQmLM
	 HC+RNzeX38A7ZWHxNePhTh0CWxXZQuuakw0InBU5ST5SMRQ0mNp0WTcxWAfvEDmPsj5Fm
	 eS7PBnV9FXKceyjM8jJ/tu5RSb7F0YXHwGB2hCvFMe41Eex0wkoiM2AeTcAKNu6PguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
	b=BA/pjb+At2y5INbTiXHEY0NPfI3FMq6qssqBqxuz5c/0tTNq3O/IPrOipvnRrZ96bZ1i
	 2jAsqp2vyix3mFA0biDluLsnUFjRY2EFGtWKmtumb0zkURZIZalJsvYslKhos+gpcR6et
	 Rh2kf2KGi4108/vcOn1Q24QMWq8BNJFNlem93KAiVRwXKQUnXuNEVU2YUHNwm7EIVcdKQ
	 fX3AZ3MBnCM5PJTP/OB03hBMzm3llT/RGyW+yB0FhA4YY+P4MxYLMDGpTMBucQf75bTV0
	 ABJ6JdZNcKIkyr6YBmgtup8CowJVPNc2cMEcIQdiAL0hCx7zCay783F6DdFIDAu5QZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9RGk4T;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA69606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA69606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9RGk4T
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-385d8a00598so7913378eec.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586747; x=1796191547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
        b=sQ9RGk4Tox3CJBgaHd1rERGLKFnMlSEy04aCuumhalHDASrM93RkBheM3kfuO487fS
         RTFW+tp4XwuGTm2cLzQvr1Ge2pYadRPBHZpVt6UPz+xpa8HKhFn7ak/N1YJbo+bu1AIC
         yagdq45DU5MqDJNP3sQBCmYdFWU916d5hc6eXEbd9H2F/g/ojM1sE/XVAvAbzg+zunqV
         O5/aGKchAF1/92KN6ghTvUf/im50ffIbXI0nxFTsGjz3YvZnqkVdbJsZ6gFrnSDFfq2t
         OBnd8/q4v2YL+eEGxvYSPFROxgOxfWusmUtxdTOKMuIuLfZfx/E3dZLIAdibltkRBJj+
         wyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586747; x=1796191547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
        b=TMm1TWI60+plY4IA4QqPJ59PmtMKSOZ5w1r8G5DyA4Ms3mhFTC0ZKjmcrf192ymVWK
         XaVdzof5mmE66FL2PsfSNlcLvKtezdigRGzkmk+YMcMZD6N0l/fJIZ/bowQczHcZy2Rk
         Y9RlfuUXDWI3E+M90Ek4ke7L9tO5NAWYT68lZm2/tcSASSJ1CDaYxqM/6Dp/Z1rStIi2
         L1Yn0miSd/6+qdGAHfpQ2Tmm7avorqDAYMF7gmFf+B5nQlLlt5r/0AspqKQeBVIG0VEY
         VtAQMRsDGC/kBsjFYxuo0s7MAINpacH72dUwUF4l1TpY1rtTPPkrhlhmzVaoDt8lWHls
         KoXg==
X-Forwarded-Encrypted: i=1; AL+hErGi24GbXlHtIaJxhsN0qy1YKcytP0E1WA0PM9Wou5h9mlG/KHXyByVbT8/Ekd7ZiccFrtI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0jpMIGfBU0cWZGUuHGPCV47x9y7jIhuEEyAlxyEaIoCpa0Ptu
	MfodZuL3Fazd2DPqbshbFWM67KmESa15Un9HaFf7cYQz49VfhkTBYtIJ
X-Gm-Gg: AZFdTZcD3MLHmLQP1jxz9kdNmQnE+PXxv7e4ELQ030a7H6zHbki1nO5zz0Li5145xMy
	w6HOMmEaN3+TkFActgD3U5SewHDOQ04da7+At/EJg9IGwrkDzf4T9p+/U2oBycYlNwPZVQ/nmXi
	Zf68/fOprHSUP22oPqND3+5GnK5773qOjjGOTUm4bY0Wx5fFBamDZnoAUrJREbGJHopSa2qAk30
	Yrem2gYBq9v7M5B6Tn8frURiWGGlAYPR8M+ikLmNwiuUA0py0Soed4pOBkUHG2mC+Uco2cfIoqf
	zODAjCNx+avw1VM4iqE5WIDvrXx0QpysQqFflqpG8dakBk90bdTJHprQskouIGKBOPKA9h+nUuF
	iOTC1gb+JcoVj3sEupeo0zt4YpZPxkxoY2Nibo+guBBwHwO3XtnNTW17ezr3DyNGJjV6FyWBNiQ
	xNZJp8pCZf8dXRn+QHKtf8pJZe5xAW/WicWGySfZCu241g2Ps1eQmFSQ1u8MntaOmXRdvIYp9a2
	8+94EIzB4Feb4f0t4I6O/lyIi/Pjwa4Jv8dIpqJuxIvKqWWfuXyuKZpW/yNCxQrOERbHeyoiy5K
	NO/yPKEmi4NCVbEaVRiLLs9ZnpL9SyLi2JiaMUcHapnNpH0LsfbsWlOp9TVpOZkxGkAUX14VWQ+
	5
X-Received: by 2002:a05:693c:8948:20b0:386:b08e:4b7b with SMTP id 5a478bee46e88-386b08e4e93mr8414503eec.29.1795586747002;
        Tue, 24 Nov 2026 22:05:47 -0800 (PST)
Received: from O1PCCC03033100.cn.corp.seagroup.com ([143.92.127.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm57080152eec.26.2026.11.24.22.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:05:46 -0800 (PST)
From: "chenglong.ma" <longpareto@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	2312891301@qq.com,
	blum@kernel.org,
	co+6dcbccedc9ec6452@bugs.sh,
	eperezma@redhat.com,
	fangxy@xiaopeng.com,
	jasowangio@gmail.com,
	kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com,
	lirongqing@baidu.com,
	oss.patchbox@gmail.com,
	p@1g4.org,
	phx0fer@gmail.com,
	physicalmtea@gmail.com,
	sergiiushakov@google.com,
	shubham@octane.security,
	stable@vger.kernel.org,
	stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com,
	tjdqudcks0424@naver.com,
	tz2294@columbia.edu,
	xieyongji@bytedance.com,
	xmei5@asu.edu,
	yuz08559@gmail.com,
	zenghui.yu@linux.dev,
	zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Date: Wed, 25 Nov 2026 14:05:32 +0800
Message-ID: <20261125060533.1296-1-longpareto@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <awWOpS3HR_2FTN3I@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org> <awWOpS3HR_2FTN3I@gremlin>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 01:51:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> It looks like it doesn't need VM_IO anyway, the other changes in the patch
> make it redundant AFAICT, so you should send something like the below with
> a Fixes pointing at bb2e6f166547:

Sorry about that: it went to security@kernel.org (hence no lore thread),
I did not test it on 7.4-rc, and you're right that VM_IO is redundant,
since vduse_domain_set_map() is the only way vhost-vdpa entries reach
the domain iotlb and it already rejects anything backed by the domain
file.

I'll send the one-liner with Fixes: bb2e6f166547 and your Reported-by
and Suggested-by once I have actually run it on current mainline.

Thanks for catching this.
