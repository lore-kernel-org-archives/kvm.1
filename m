Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427672;
	b=h8aNInh0PL3y8PxKOxzrB9uWWqe4dGHFVt52yYTgfqvkB3RK47T7ShmGUC5Q39aoB4gO
	 lhsTWoxVkizfkeXs74gfhZCiXxQzItMMJVk9ypciix/vNeD/M+6JIg6rnnhEHCOSkNPVN
	 D4RAhJWvvyCBPgohVT5LWO36ELbVedNZiBCg92VSw1cB2tK+IKkEBcC9ycyu690aK6jCL
	 5I6lIJZ8HUKkslrNd+s3ugjFF3w7m+AQNrjVNO4VD4x3SOpvXRF4dzTkCS7ZNl1kllz81
	 rUxMBgFDnLebM4eSp7bspNRXm2LiW6HZL2VdHYqpU8C+ohZHC2u1zKGEQWSzNMDF+zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=5EMCD1rtKeIzP4pmI2Kq0aEOHvbQvIVCDlgtYyGqRvY=;
	b=CtPxWNGOVGQ28LHwPp9G3zz1sDtGM0YDPwxEy6HTWGngLM8zD4YZuKMp9oHO2jw7Dsgg
	 vmcOqZR/pTF+mXxDueBjle+XFmGo2CkvavuugLG9QdNWULK9wn6HN/cETA874bZb6r091
	 ZUpOz2xNux1xsGQfHk/yYQWcOEtEz5iZg5DBiyU6tfE3EznPMsZvU5agGtORbcWjaV+1m
	 CtAtLURffKcp+T1fPbQkdCU55S4IIb8Gt03j2hfO64zspIigdmB2/pHYjmMPyOVckrM0V
	 yn5O5c2hlJkLvKCuZAkeeDx0/nVdRgorCszIgtiZqfH2++Kwg7bGQgQsA+GX/8ergUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ib994pDE;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C8606A326
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 20:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82C8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ib994pDE
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so1613982a12.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794427671; x=1795032471; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5EMCD1rtKeIzP4pmI2Kq0aEOHvbQvIVCDlgtYyGqRvY=;
        b=Ib994pDE2Q7BaLhj22bPoqfOJhpjDDRFZvrAJjF7ehEjzTVOj9cWTjN5eyCaRLx9Do
         uaS2NF2dBOoNhOHaCI9cq6B0c4DpZT44Hwg4BXixTHzx/hoKZRKbUk2vfdj9GyW29j7f
         U4BAO1G3gUuj8dyUyzwVofzhK55MVd3KDdmWW0CyJi7QEjT+RRSF0k5VKFhX7ObI7VYH
         ZihBiev0hpknq2qZjGUOhL6B6WeIU89r6TxdMuT5YsT29F1WLV/aGEEzx20tAeRGPyaL
         zxhqro5AjHVmfqcVxw1iU2Dd3YE+92tQUea9yMj1bQgdPsP8FxxF9dTN/JDZEZO6Q3mi
         hP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427671; x=1795032471;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EMCD1rtKeIzP4pmI2Kq0aEOHvbQvIVCDlgtYyGqRvY=;
        b=s14poYziJswfP/ceF/brn4A8I5lZGTfMj1TbID5MLcKLl3l1hJoCYwugfQYL5EMM+4
         jxvDuDSYVmwgupHnpQWo4e1cu9LSAxsQH84A8cjC74kpSPA9/6v23jyQmQBqu7VmQc5C
         QZwe3sUeM1RO9JvyEyoz9nGnoeDDlsIXlH3OWp7ejBRYXa9xglcGfckIJ4dn5uWJrkh6
         E/O5Z81Bh68YShzw0duapt592Gbb4npT+PAPCm33ylIq5QlFLgYXWWfhPysChmR1Hhsh
         gVwmB/TnTUIMNrG13iAFkiIs0/1YqeCzR2T6oDMrk16q40cQ/z5M4zmBt30zr1XRSWHk
         +PLA==
X-Gm-Message-State: APuU4Z92coRJ3Il7gJ7f5SQNISnGej22EksDXogAvIjDXN3Ny7Ep5Con
	U/myNI8QTPBf/QktS5fOM/jpHquzDh9REIZN9+NGsepxYhek75J1/M+c3zrAvqCrCg==
X-Gm-Gg: AYBFou1JyyNbrsc0UEO4G2M+CbOzUDXLMH4uyjDW31ZpTVM9lPrsYiyxYEgqlHs0xrJ
	RneG/yRQ4wy0IKEc1uGn9wA+kNgRHLdBE75yv38p2RI1P5QmC+N060bXbN8tYRldOh466MaEOHe
	fT3zpM1CrRrCnukOWbVmcDo+s2Hg+nafEk0YylkkIddji2BnW/4hSzWXotY5wxdLYnVrvNyyb7m
	V+BV+6rcSC4gOYN6PS6lEAfFY+PgRyPT4Y0SEFBGWu98OVL9M6A6gGT4by+c7ScHRz8ZN5nF6RO
	dh5KPksy41GmLBk7M9mgofXdz+NMphXP002hhBKnhgz9Ktmmb6OeneQW7CQ5tWXHsRtvpwz7Q/K
	vfUdh0MVwmPF07cg+AKrjzOmMPIeSBuN6Rl8XqQarAiS3vKj9kPc0PNWV/FSR/drpDpoiK/Brxb
	t06599awMDyNuqrz/BFUli6WepDuvC6o62tf+yLNUXwkcEcKRW+G+fj04wDnRaOknUNjJs6o9+i
	Qe7VuOYZiwqK0jlA8iJlm8LgT7r418FLeuf1k0pXDTi5P2qeVmcIB/1M9ysG0EKSEEwOIKoA01r
	sETDPmLoDhxY5QbmuqyWsRSh7SnCeFc6hPeOS1K8OaC8gjvQzi6Bm0bAeMVMtfc+
X-Received: by 2002:a17:90b:5101:b0:3b1:64d3:f308 with SMTP id 98e67ed59e1d1-3b182f8511amr3538560a91.43.1794427669947;
        Wed, 11 Nov 2026 12:07:49 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27cf1sm691230a91.12.2026.11.11.12.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 12:07:49 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 12:07:48 -0800
Message-Id: <DMSNIQJ9G6P3.2L2X6PDV6QBGA@google.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>, "Abhishek
 Sahu" <abhsahu@nvidia.com>, "Raghavendra Rao Ananta" <rananta@google.com>,
 "Shuah Khan" <shuah@kernel.org>
Subject: Re: [PATCH 4/5] vfio: selftests: Add sysfs_kernel_warn_count_get()
From: "David Matlack" <dmatlack@google.com>
To: "Alex Williamson" <alex@shazbot.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261029203324.1637772-1-dmatlack@google.com>
 <20261029203324.1637772-5-dmatlack@google.com>
 <20261110103434.48709eba@shazbot.org>
In-Reply-To: <20261110103434.48709eba@shazbot.org>

On Tue Nov 10, 2026 at 9:34 AM PST, Alex Williamson wrote:
> On Thu, 29 Oct 2026 20:33:23 +0000
> David Matlack <dmatlack@google.com> wrote:
>
>> Add a helper to read /sys/kernel/warn_count, which counts the number of
>> warnings (e.g. WARN(), KASAN, and UBSAN reports) the kernel has
>> encountered since boot. Return a negative value if the file does not
>> exist, e.g. on kernels that predate it.
>>=20
>> Factor the code to read an integer from a sysfs file out of
>> sysfs_val_get_int() so that it can be shared by both helpers.
>>=20
>> This will be used in a subsequent commit to detect kernel warnings
>> triggered by tests.
>>=20
>> Signed-off-by: David Matlack <dmatlack@google.com>
>> ---
>>  .../vfio/lib/include/libvfio/sysfs.h          |  7 +++++++
>>  tools/testing/selftests/vfio/lib/sysfs.c      | 19 +++++++++++++++----
>>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> I have a concern with this approach.  I run selftests in parallel as
> much as possible, using multiple devices, each targeted at specific
> tests, with other functional and performance tests running
> concurrently.  When wiring this into my harness, I initially saw a
> failure, but can't reproduce and have no log from the original event.
>
> I've updated my local CI to keep a console log so that I might have a
> chance of chasing the next instance, but I don't much like the fact
> that any warning occurring concurrently with this test can trigger a
> failure and the test doesn't provide anything to go on in the test logs
> themselves.  Thanks,

Thanks for trying this out and the report.

What do you think about keeping warn_count to detect warnings, but also
reading /dev/kmsg so the failure details are captured?

 - In setup, record warn_count and open /dev/kmsg and seek to the end.

 - In teardown, if warn_count changed, read the new /dev/kmsg records
   and print the kernel warning reports (WARNING:, BUG:, KASAN, UBSAN,
   etc.), including their call traces, into the test log before
   failing.

That way, if the check fails, the test log would show exactly what
fired and you could tell right away whether it came from VFIO or from
something else running concurrently.

To avoid breaking setups like yours that run lots of tests in
parallel, we could also make failing on warnings opt-in via an
environment variable, so by default the test only logs the reports.

Alternatively we could just say warn checking should be up to the user.
