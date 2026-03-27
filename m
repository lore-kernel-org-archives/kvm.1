Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589142DF155
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625008; cv=none; b=SLDCovFHfJzJyun5kt2oMoh2ILgWl68U4uJXLi4hRsO1AYERVUTlf3iRIOXPL2AAptN3GvDo7A+6hwGqayWXM428WTCm3XcQzGUIIDburg4e5fzjzYQ1SFMtywMK64PWnB8OZ3HpOGh0EmCwBE8Ze+XCnSm63ejQucE36EpWHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625008; c=relaxed/simple;
	bh=QGX6i54s5UgwCH2JsvP0SWkUtgqCo1Z1Jbyn2R0CQAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr1ipH9jK5w5AdW19LDr3YJpjF3wJ8hn6tbA+FFxGgETUaAzp+cvH0e533Fra+EQqDEAL+FrzNQM5lf5M6j8i8h4pOkog7EXg64akzK2BgfRH2a6MnzVXvtY/oEaysOTkX9XGXFKryJ7FnQ4EeCYqS939KWaERwYA5cRHTyZqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T23mygud; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T23mygud"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so4218804eec.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774625006; x=1775229806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PzJcmu/U65FU4wQTMalP+dP1gUaMd8JFyXaRRb0LPKo=;
        b=T23mygudOHgEgVw0Zg9uUfDqdzhTr9iIPjB24Z1e9T7SADBUkY0sHEXHsRHp6I5zAq
         f50TM4Y+dQK9shXHeYyptbnP12GRsb9SCpFm8u9Oj3f9w9KQrpOZpyvPuYQ5YiI3oc0t
         WJVeC6imr/L2PH63a9bk+R4fTSyLjagJob09L3wnlJUkRkDsVMTU6wES8zBLaCJaLEDS
         25uAHeHnVJP3VHfcbjwiyYp8C3LeotTwzwp2SUoE3KWvKtWrEiiHuj25td3oHAvHVOre
         1gP3GFWvwq9YRPbvagOtaEjiElN6lzWfFalR+XzQc0H6IakV+fWWQu+h8hPvg6Eqzo5d
         TvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774625006; x=1775229806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzJcmu/U65FU4wQTMalP+dP1gUaMd8JFyXaRRb0LPKo=;
        b=KoypjrnSmJARTi9V8zoSpSfjx2QtyKLZgeWi95xBqd3Xtad1miwo8jHUfr2TYRF4Zr
         P8hXXwJ3zZ1qdqiKNPPTg1rHoBnWB/uIRW9hYJ04uSTeimh6RtxhpG4nvq0LxzAQi3gc
         SXZ7e8YOA5kqWwhn5qFJlfyWYyN5B0xwsLtSYWHdgWPf/8hEJdOPsoaKk1xO9Il1nbwR
         HjDPTQ5PwWHB/kuCMhdn1JFauMWrGVpmMP6CqAyv+bmD+raap7hmtBqkVagNlWl52Krd
         GJPT5aAvHnhwRTENMMy7JjLufUnbJSU2gKch5153PpZNBTO+183n9Zweci8hvvNo9Qoj
         GA5A==
X-Forwarded-Encrypted: i=1; AJvYcCVgdkRPQ5BVqyYPBzuBc3FKuwron1rd26qCq0MLsNz+FYZOSS2c6sQAuYCRNyCCv3QOq4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+Jwku6wfh20h4SSRga1B5koaycDJdZ0CQbN+Vx6rOuyMx5FF
	0BK6cipw4ezGvdgHky5IP7cq2LPO9/6jkCl3J8YcllsR+6w6cvxEIerR
X-Gm-Gg: ATEYQzzfE7Tgk2msfK1YEdxKt39WBZ8JN9qra95F+nLkVor1YaKPqRS0BjaSHQ0z63i
	W2KKMSXckUp9TcSd9Vc8GVwztoWAfn/YWoQwMNB2y3ZuMjHkCG9asKDH1Mzns6RepRysZv5+PB6
	yZNxYAHgvhQBQnkJv9xxx+aPFAEKTicJmxxJTm0PX3VzR6E7f+l3kwRuNoVykYtEgeQUJyyaHaE
	VPraBlQan6NwfDaanwzDcRgvNrdoH4AEiPaiFik4uZC0ew7BU1yXQ6ysmaDRUNwQ/nGXjFYCGrS
	m6mxSfjkljdJM7xCAyVH5yZrnwGNF4Rdap226xR1+Ube/CwkZKTuD7Q6oDTraS5+Kjf8UW3X47/
	gTHSqSCfSfawa9ha6dxqTTli/kfGOekM+h9bRKn2RzhLQbqDPUvUDgAjRwVXHVJCRaNUYjnkgij
	lgyuiOY+kYqFAI1jpnf+Kxdh+9r/dO6GjFE3PSU9k67dvNLLHzLOSJ4EyKdvfx+8qqOrEEOQsZL
	+bOF4L/fC8t90ZANzE6Q5RMsSC46Ac=
X-Received: by 2002:a05:7300:3254:b0:2c0:d92c:2c68 with SMTP id 5a478bee46e88-2c185fad9e0mr1793181eec.31.1774625006061;
        Fri, 27 Mar 2026 08:23:26 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec4934asm5319735eec.8.2026.03.27.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:23:25 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:22:49 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>, 
	Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
	Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 07/15] target/riscv: Use glib2 instead of
 strcasecmp/strncasecmp
Message-ID: <acagsTxLwZYmZaf-@ZEVORN-PC.localdomain>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-8-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327134401.270186-8-kkostiuk@redhat.com>

On Fri, Mar 27, 2026 at 03:43:53PM +0200, Kostiantyn Kostiuk wrote:
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> 
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  target/riscv/monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index a9d3111444..bca04a7580 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -303,7 +303,7 @@ static bool reg_is_vreg(const char *name)
>      }
>  
>      for (int i = 0; i < 32; i++) {
> -        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
> +        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
>              return true;
>          }
>      }
> @@ -358,7 +358,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
>              continue;
>          }
>  
> -        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
> +        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
>              continue;
>          }
>  
> -- 
> 2.52.0
> 
> 
