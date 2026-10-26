Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983294;
	b=VFF05V9YPs7QtEKU0tE8yf0gi7AOfkEJtccNBawSwgImwHOnlC70MYREb/v1b1Ev4/a4
	 pmQPLlEo41yewDIPtblPKPgZ0ux2a/WmDT9D3rPgwJMLmEdR0/b3WEpXEOMBwpnOI4XU4
	 3hATjaJz7gXkmXXkN+YZmkogIZSws3+jDF+m5ixFFMdBuG24slqxnFgY+2XeeDh0jLP0+
	 lfUkAsx3t/Ci0oodMSbpKy65SsU/42kFy/c/nmGzan487eAqBCcIimt/BMBVV8u2wVsA2
	 hWz79hs59R8W1LxImkg1hvj8RR3cfyLpnJoAH3Z2d3akKuZt6HQejrvU1Kp3gsGy7Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=O/IOyk0aeiwbjnpRPbiHFXjKM3OS9bO6qM44PQ6xvNk=;
	b=LoA68ZS+CRCESlXvY5iILOzMiDjyHwAM6y2GeMi59fNmtEogeerLUJg9z9Q5bVDWFb8x
	 LMaIdRSm0S4M1s4Q26LQnN8TVob7Q4DeucNCCIHvBrkbprjWkMIGIGyBAlI+PWgNXK28a
	 /M71WL0vjAzneWwpEco8c77BPCNe3yHAEcksrM5PdYm3KgKcEYnMFIMQ6kA2F10j2UHe3
	 753yQdW+VUmBvxzyfO2EeYPOlM9JOBnB4JYd1VnRnGpd8JEwY2jfP9A8zcHR7hnBoK1KY
	 CarncEJKP4bIVemLfWICe0FdowHH2b8VwZPBD1nQsYdDHR9zljx9Qzduvg4F6p1SggQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EbvC2jga;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E8606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 02:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EbvC2jga
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-19305bcb72cso1586351c88.1
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 19:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792983293; x=1793588093; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O/IOyk0aeiwbjnpRPbiHFXjKM3OS9bO6qM44PQ6xvNk=;
        b=EbvC2jgaL4ffIhUMR7Z3XzdyMQoA4XmjrV02lN4aRXPeRi0J2KfC7L7wIjSTSFsHSz
         diovwEz/KOnqsoTOWslK4XLBPJuu9nk2lXIDXqqQMP5SLS1CFtNSHzy56K+h6cmYkp19
         supTs47cgx7TnwbCsBPr6qnNmoko3AL3R860nVhy5zyX0cjLYUr6w8bmBXQiS+joDDGa
         LgqGo4h01N07BLCQQxpryuM0HJZIpBDs66ZcgcCoE3wsFhxgFxyiq1CiurF2ap8zgUy+
         80HaXCREMcUEk9PptyW30xGOGOgAKFbk0H0L27xjQX8Zpt5qSyHFXHW9lTW7ADr5qgeo
         oaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983293; x=1793588093;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/IOyk0aeiwbjnpRPbiHFXjKM3OS9bO6qM44PQ6xvNk=;
        b=pwZGAbXE4AndFlCbG4OWYVMkkHzUTznKYcmWBOn0hM14nc1K5PT17qb+FBoMNb1tI5
         CFoWtxlooF7PbrcHAub5H81+z/lGkXEYut/FxHfvu0z+a7yc9nxdSpoS8Jo4oY1jOPb+
         jXJbI35VAkvbXMwJtelSDvh2ZtPoqN3sbYNYtOfuf9D5aqx64ZHJndhgyC5ifYF7IOtI
         N7rnUhoTwcJ/Gu/t85CBX1zUyI7UQfy5DU7wgllGJNVy2+hHU+qVXkckbbQqqSJi7A6h
         VeDaFmE4/Bjh/cEWrD0TUdj9IxqxOMMiRohvEpe6GwXRuP/S3KlsxL8NKJRQLA4yTVik
         uFsg==
X-Gm-Message-State: AFq9FYLpxpX0hczlLsz1DtewSzQvOwk3wkbzVfTLVLoe93Hss7FJZqGC
	Kc5gcN1p4NDsTqPTe+6efc77W98l9ENujf9lswrGZUUBwQ4sIl0vxkWSyNOEI6zklaE=
X-Gm-Gg: AYBFou0w9h0fKGl0Y5VHURSAhKmict/jw7qnRYvYGxGm0DVY830bMRmGv345bQNu0fd
	8CbpE1fAAOUtmJu9I2uGJca/5mXIobGd0o+skaP44XspfTH8HIYX5cfTEkdHyNg425KpEgr4Kyq
	evrsaRwhWYNXuCez2fVhwdRGemXuhxF8JZRbSkzoXCYsNPNb9TN4jUPt1HxROtTrFRp5sgCsTx9
	ytmi83SY5PvRMVyN8mOAZGoCDuoQrHxwUrluijEVbLoom99pPf7ECncwA7Go+oaFkEY90aQXho8
	+wfAPzt6ihMHARFP/WPN08VZZaIDjM0ahdIUcVdUegjIcG/OBtAvJvVKC/9pl65ClkFdP6gvRzO
	lJwmWKybxtxj59CfJ0mJlkfTRSNImlgSOteYhdoox6wvfTZrdrSDdiI1qr2mS1pEJn2WDEjefYu
	IEVyvp/BSLxl2siaCX0omSmA7zc0gVfJYZniaZP+tNfGcw8WZ0GDDYjvwp7MypvPCrFJile7rLd
	Nqpib69KePsaG+14DdiBBu3PO/ObapSr/wA1a/b8NmdbEQPG/7PZOs8D/lBXMXoEksVaDEYBD6n
	52rNmbB8Cw==
X-Received: by 2002:a05:7022:4585:b0:147:a685:912d with SMTP id a92af1059eb24-1993580ef4cmr11608601c88.29.1792983292830;
        Sun, 25 Oct 2026 19:54:52 -0700 (PDT)
Received: from smtpclient.apple ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm27803493c88.4.2026.10.25.19.54.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2026 19:54:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [External] [kvm-unit-tests PATCH] riscv: sbi: Fix timer delay
 measurement race
From: Qingwei Hu <qingwei.hu@bytedance.com>
In-Reply-To: <atsy0DXLV-WNdi-c@orel>
Date: Mon, 26 Oct 2026 10:54:36 +0800
Cc: kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7E4D434-C723-4739-8EC3-1A8EA6C2F3E8@bytedance.com>
References: <20261023030442.3709880-1-qingwei.hu@bytedance.com>
 <atsy0DXLV-WNdi-c@orel>
To: Andrew Jones <andrew.jones@linux.dev>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> On Oct 23, 2026, at 18:13, Andrew Jones <andrew.jones@linux.dev> =
wrote:
>=20
> On Fri, Oct 23, 2026 at 11:04:42AM +0800, Qingwei Hu wrote:
>> The timer test samples the counter before checking timer_works in the
>> wait loop. If the timer interrupt arrives between these operations, =
the
>> handler sets timer_works and the loop exits with a timestamp taken =
before
>> the interrupt. That timestamp can precede the deadline, causing a =
false
>> "timer delay honored" failure in both the normal and masked IRQ =
tests.
>>=20
>> Record the counter at the start of timer_irq_handler() and use it to
>> calculate the elapsed time. Keep the loop timestamp for timeout =
detection.
>>=20
>> Fixes: 14fa12b1351c ("riscv: sbi: Add test for timer extension")
>> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
>> ---
>> riscv/sbi.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/riscv/sbi.c b/riscv/sbi.c
>> index 3b8aadce..a298228b 100644
>> --- a/riscv/sbi.c
>> +++ b/riscv/sbi.c
>> @@ -245,6 +245,7 @@ struct timer_info {
>> bool timer_irq_set;
>> bool timer_irq_cleared;
>> unsigned long timer_irq_count;
>> + unsigned long irq_cycles;
>> };
>>=20
>> static struct timer_info timer_info;
>> @@ -256,6 +257,7 @@ static bool timer_irq_pending(void)
>>=20
>> static void timer_irq_handler(struct pt_regs *regs)
>> {
>> + timer_info.irq_cycles =3D timer_get_cycles();
>> timer_info.timer_works =3D true;
>>=20
>> if (timer_info.timer_irq_count < ULONG_MAX)
>> @@ -304,7 +306,7 @@ static void timer_check_set_timer(bool =
mask_timer_irq)
>> }
>>=20
>> if (timer_info.timer_works) {
>> - duration =3D end - begin;
>> + duration =3D timer_info.irq_cycles - begin;
>> report(duration >=3D d && duration <=3D (d + margin), "timer delay =
honored%s", mask_test_str);
>> }
>>=20
>> --=20
>> 2.39.5
>>=20
>=20
> Hi Qingwei,
>=20
> Your patch is fine, but I think we could also just change the loop a =
bit
>=20
>    while (!timer_info.timer_works && timer_get_cycles() <=3D begin + d =
+ margin)
>        cpu_relax();
>    end =3D timer_get_cycles();
>=20
> Thanks,
> drew

Hi Drew,

Thanks for this tip. I have tested that the recommended code is useful.

I'll send a v2 with your suggested change.

Thanks,
Qingwei

