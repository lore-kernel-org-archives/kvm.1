Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358315;
	b=BBLhNtNaT/CJptLTNzGjIv7jpS6Avwu9Ekd4GgsnlQMi5J3gROo2sZxRWi6wv/bHoMKj
	 EVZdviY8r1Qd6dVMAvQaZGAz8jXR8vqtjDAGzSQygT5F2MNP/uyQhgV5LztRUZVa1Dq/y
	 l5vSIpdtYwcHWF18vKe6QHqcaIqbHJxbFm2BaWEmNOOsOSdPstlFWedFM+4HJqr1ermsx
	 aGvN6JY4E3F5ZxEzPdH54RJm1WSAUYto++HM/2dABQ7pYN7f8NlFFz+IIVbCS6OqjhkeD
	 /G1FIf1iy1ax07N0GCIPP7WZ29gPf62dhk/LtZY81RMvkOJETbegskDF1WdCQztc5+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
	b=0OgspuE6RBrrkp6FTJQaDoYF8D7D7A7rTzXiyL7bmUeXnN/Hiag8nREPo3tP2VcBJkLq
	 opZSz7UN3T5wp+82ftVpWSXxZNP1QJdP6jmI2aop9d1MExbu9LXnqBHr0P93T4WMZYQPo
	 6eGOZQ0FqVLWUZOTohRchFbbQ5BgI+/fBAS4coUHJ+6K1f7hZr1HKQ556+W14zO9LuVHy
	 DroTFBmv+oOAJwCNJ+hzvv7IORsk35ZlAzOgf2PwWGc4VIeT3raXnvgnFWiCqTwgFOg2i
	 b7ZOL1A3y8PTDC9cRDWAosXrO0QoqcYzaNv8B4Ti85/+aSgUzotIAA8npfj1rRUrmGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=AfkFgl4A;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602B606A339
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 14:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0602B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=AfkFgl4A
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-92123f02faeso25363176d6.1
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795358314; x=1795963114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
        b=AfkFgl4AHUA11Cz2zk8WBBwMK+X/HIDzRK5+MYdyi2ng/C7wpuCEEaLWnoeurwqvhc
         un8Y9P/KDffzAn5QBJDeL95Aonms5uE7VqyjYxlDXnsQ9+vnFoScbxVFG7Dr/LMkHOCp
         YipueMC5yBS8tK17Sc3TAIfKjE6glUoTJx3lJbFarCR4x9CstDkU6KBjnKZ5ECcdXJd7
         rfX77s4AmQcKf+/3t7duDnQDJEudfPbSV1EUFq5u7GTJj3K8Hfuoq2MM5UZFPpsvLmsS
         z8Eiy9QQJzDIkaBR72BN3SlcRBurKtzYxdgpoEgVrs17Nz+Iy/+xd8YUONSHPtLaM/3i
         QTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358314; x=1795963114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
        b=Af95XyV8uTG9kSpPAntbbq9kxobJ7ldL5SnDTjMEYBUcnrM8oTo5dfEa8nww4WwgpR
         g4NVi+XsGEtvG6ZVuEXnVu1AmqUrYCZs3Z5fG8m2+yjkdVc/7lenPDT8TsP0qmD+e1Lr
         wdaC5W/od5x0q1A8OxguGsZ53XpBfl27PokHwWnBBexdLk2+2c0KO+Sy87PxBzZ39gUr
         UuTLKGXVYC9HK7FF/K85OVolYibkgGCDp8eabk38AdN1xY2/vWkeC35VE6oVIMuibVQn
         tx4mu9WLpoNnvA3HS8C/Qfl2W4wBh56ylfe77tzXoEhk79vo0LK3uMezS/DQj8+vHoqi
         HH5w==
X-Forwarded-Encrypted: i=1; AL+hErG7i/gjcYlYY1glCD+syCUWZ2gi9Dbigb96xt5lkvAJ5G459hJxqe48RWCxR4VPyIauzME=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hIhDoZogVgzpJnrctmSRaFdEl9E1I6yTcGvmXP2xZfssUW2Mu
	rrBWEC+R7Fh0e8APhlikJ3WSfgHTbjNKuMdar9xvwCRohraHWSGtO98/z+MeSHGjig==
X-Gm-Gg: AZFdTZcncEg6CpMRDxpscRRc1cqF0MbpSlMo0rhUV9UUgYdlDzf4+qEXSMauqjb0vKs
	vthf57/4Y36pZgx6v1X+Nu1mnahsE5rNLJaLBL8KPYy0CBI0UvP6HSY5E8gZMURDd+U6D0qba02
	dDM7sY93UhUwR3iXPn1XK5tr56B1rvhTbt6VEmtN7RnKRPFUIUNnmFieKasjFtJrtY6jws0S7jU
	MP8qNAykXoavhIHta4XKBZr4neacsBx5vB1U6y0rjlwT4BgIvQDeqykTmxnyOujWIQooezNOxni
	WHkhlvWNAb42tiZY3ZuYB50RzH6/DZxDHsMuFLGf2Y63fos5x5BQmA8sAH7eMOZdJ9A094XApRP
	ocVC/M2uJdRI5x0+os0T2vjHbmsXQxCcWrUKGmRFvdsP/Y+g2mrcI9+vbt+/1W2e/GJeQN6xECZ
	mE0D9hGOi/wH8OxqOy6qvgh8j8D3+D7mERJ84dSPm3VF5WBkfkDsZ5KALdkcU3bx/6r9GPKwFpZ
	/LaY/2I8uJ2R1v26H4cLwsDygWrhgs+o9luRxLzLCU9C3MvNgLDCdnZvPefgRbOc38L+sl4UR38
	wst2/l1KDJDfOu76fr5KxnAkLmUN0FXmdRgjXNTc8qWh4sv1lWxt
X-Received: by 2002:a05:6214:5015:b0:921:8d9:7f8e with SMTP id 6a1803df08f44-92134a6ded7mr155188986d6.12.1795358313858;
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm79665516d6.39.2026.11.22.06.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 09:38:29 -0500
Message-ID: <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122092235-mutt-send-email-mst@kernel.org>
References: <20261122092235-mutt-send-email-mst@kernel.org>
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

On Sun, Nov 22, 2026 at 09:25:37AM -0500, Michael S. Tsirkin wrote:
> this is followed by:
>
>                 virtio_features_zero(all_features);
>                 argp += sizeof(u64);
>                 copied = min(count, (u64)VIRTIO_FEATURES_U64S);
>                 if (copy_from_user(all_features, argp, copied * sizeof(u64)))
>                         return -EFAULT;
>
> copies at most 8 bytes.
>
>
> did you test that this patch actually helps anything?

That first copy is bounded, yes. The unbounded part is the loop right
after it, which is outside the diff context:

		for (i = copied; i < count; ++i) {
			if (copy_from_user(&features, featurep + 1 + i,
					   sizeof(features)))
				return -EFAULT;
			if (features)
				return -EOPNOTSUPP;
		}

It reads one u64 per iteration up to the count from user space. With
count = U64_MAX and a large zero-filled mapping, it only stops at the
first unreadable address.

Yes, I tested it, on the vhost tree at 44293796526f (KASAN + lockdep),
count = U64_MAX:

  1 GiB zero-filled mapping:
    without the patch: EFAULT after 27.4 s
    with the patch:    E2BIG at once

  2 GiB mapping, SIGKILL sent 1 s into the ioctl:
    without the patch: the process is reaped 46.7 s after the kill
    with the patch:    the ioctl has already returned

I have a small reproducer (a few lines of C). Since I found this with
the help of an LLM, Documentation/process/security-bugs.rst asks me to
treat it as public and not post the reproducer to a public list, so I
have not included it here. I am happy to send it to you off-list if it
would help.

Thanks,
Hengyu
