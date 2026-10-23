Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741059;
	b=CfvUn2sC1SEhoXerKGMJ8YFlRu5PIj+9E/QarezsYQBxQmuFQ+NqB3uYCEareTGzzDxC
	 ux7wNuIrNK/T3sfoBAkenLXzT+WsnosYoyxUtalfd9KJL3WxeUwBwk3bp+e173r41ZaAn
	 SA/smOhUK8AjlhswYKkQpIaYtzwVx0DLGs8X+spv3Yk08CgTKcNliashtTpQ7jO3tRWPY
	 xxg1tHZ19oFqNh3YMgLhTN2QUfcg7owrl71a+p1vGQKpyuqHrRXk6tDVUmpJ/emdrY2V0
	 Rt/Hp5CaWNER//gIg4UsQf1Tm8e5JwDy+T3zc/tl2pcJlWjKwfEhr/PQUVXEhte5yLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r4YBy/SHvgVV9nXhiYBv1r8DYq8G0AiO7fdNVfHKjfY=;
	b=e8QjJxxAeuYKts2GHtJYKj3tm44m3Y37Fb71aRMvnV6+5fMSsKRZ13q9W1e88vTNASAH
	 Lc81zYZACIwryhi1LweO2hKhwrhgbuJGjk5s7f7EPMksPZwJkHFuYObnS1qWjchbliL0L
	 YZF9jpvIvlxlXPpJr8e0Jx1HVebso/hdQrx925eki/yg8umQ0gw7uCy9Njh6i5+W8KbMj
	 1GTrBDI2C4X/MA3X07UIsUuEiaVjxEaiPjQnHqikv3xH9ZqvIaAVsfuvQOyFv2Q5vn+R3
	 Mnk/hPmAqMg6uuwBcUaIAaapxn/2qYXaLaarYhzzf10l/6k5WJwxR1pwLY5FC0DL9hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nfqozi7F;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A8606A322;
	Fri, 23 Oct 2026 07:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6A8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nfqozi7F
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EgcB1101710;
	Fri, 23 Oct 2026 07:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r4YBy/SHvgVV9nXhi
	YBv1r8DYq8G0AiO7fdNVfHKjfY=; b=nfqozi7FyanhP1B3E0DIur14THwK5h72/
	jSvoTj263yhK7BUfWTDge5HpgEWWY50aZmvZ8orPkM4lpT2aJ2euOrXRza7/I2Z+
	8cc7xbLylXxONsMdfoo7Ty5aWwk11N8v95tzsQibSB7MHWbQnOWUsuDKivrN4yzR
	VJ5Ol1z7oXwdapDXkPZqPCMLtKYO70wFjWRVRJkpXD1GsU2wsa1c/65uHkuK1ytZ
	xwIGP+aTBF+C3G4aDogUTDl9hR542exNXshXuvcUTNUlS36QP8YTxURMqjSBoF6G
	GL8u9ptrPBln9o7kkoALe4LNBcE5C5M2WPt2nkSzvQ3scq2IJrkwA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58k7bd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Z6GB1742823;
	Fri, 23 Oct 2026 07:37:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgk0e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7bJBY48955898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:37:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E2002004B;
	Fri, 23 Oct 2026 07:37:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E62120040;
	Fri, 23 Oct 2026 07:37:15 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.39.18.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:37:15 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v6 1/5] powerpc/rtas: Handle ibm,open-errinjct return format
Date: Fri, 23 Oct 2026 13:06:38 +0530
Message-ID: <20261023073642.59657-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfXxtCj2DreJae1
 3zzW0AIXUolQXMRHsY/fPB91Aoy44yxLkYl/h7Md3g3VkE8906SNh2mtaLic4qXKXME2iNYs/Mh
 VqLkL2Co4WpMRAU8+xNXoaU38pr6/Uo=
X-Proofpoint-GUID: reXkLwSboGh_AYKg22Y6QOGW2lhnkAUI
X-Proofpoint-ORIG-GUID: XEh_9PZYJCijpVl2kfepy1_XUwnBV1pO
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb0eb4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8
 a=UsokGn5mh7P9jOUuuDIA:9 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX/U602YaRnAk8
 8rfKMQpMfvgnLX+t2d5KfJg9kQGadL3ucF+yqdAX8Q57L65xtEgt1HSK7bba44J6hoi+6/rebcY
 IJRZ6NQPWrefV+ZzqUlOfPVNDWn9mqn+ZGhoTis6Zphf1U18tH6v71bS2Hb6D9bjUOnte9PLAlv
 EDS1ICunqEoHDw8M21CQvJg9BZqGj3RhB6RE/XJ0oiJHA1WBYks5ifkUVnqqWgHpaLkX/nwuIrL
 AUZ6Maco7S0amSjGi3K41sXBJssUeiMxwjoXhx38QjaBg16HbOIM/W/egQ7icbPyndjhrLU9Er4
 G3O//90Ig5F/jd10FT/0awHYGfliYi7luHr58wn8wnWCTbs+eNQGRas9rLJoNvc9/WeREdNaOOt
 aAIgONktOkrPiBUZufXGIguSO7zwt0ATsjq08DdyYrg/jZJmbLtIg0Yc32yV98ipeNxAa2nR5Ds
 SLtJ+syA1DHv5QvCWrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230028

ibm,open-errinjct uses a non-standard RTAS return layout:

  rets[0] = session token  (output parameter)
  rets[1] = status code

Unlike all other RTAS functions which use:

  rets[0] = status code
  rets[1..] = output parameters

Add rtas_token_is_open_errinjct() to identify this call, and
rtas_status_from_args() to extract status from the correct position.

Add an early guard in rtas_call() that rejects ibm,open-errinjct
invocations where nret < 2, since reading rets[1] would be out of
bounds.  This is a kernel-side call-convention error, so -EINVAL is
returned rather than an RTAS firmware status code:

  if (rtas_token_is_open_errinjct(token) && nret < 2) {
          WARN_ON_ONCE(1);
          return -EINVAL;
  }

Adjust the output-copy loop so that for ibm,open-errinjct:

  return value = rets[1]   (status)
  outputs[0]   = rets[0]   (session token)

For all other functions the existing convention is preserved:

  return value = rets[0]   (status)
  outputs[0..] = rets[1..] (non-status outputs)

Move the "/* A -1 return code... */" comment immediately before the
ret == -1 check so it documents the check it guards.

Also fix sys_rtas() last-error status detection: add the same early
nret < 2 validation at the syscall boundary (returning -EINVAL) to
avoid entering RTAS with an invalid ibm,open-errinjct return layout.
After that guard, use rtas_status_from_args() to obtain the RTAS
status for last-error handling.
The prominent user librtas already passes nret = 2 for this function
as required by PAPR, so well-formed callers are unaffected.

Reference: OpenPOWER PAPR documentation
           https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 78 +++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..38f3d08d4228 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1117,6 +1117,28 @@ static bool token_is_restricted_errinjct(s32 token)
 	       token == rtas_function_token(RTAS_FN_IBM_ERRINJCT);
 }
 
+/*
+ * ibm,open-errinjct uses a non-standard return layout:
+ *   rets[0] = session token  (output parameter)
+ *   rets[1] = status code
+ *
+ * All other RTAS functions use the standard layout:
+ *   rets[0] = status code
+ *   rets[1..] = output parameters
+ */
+static inline bool rtas_token_is_open_errinjct(int token)
+{
+	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+}
+
+static int rtas_status_from_args(int token, struct rtas_args *args, int nret)
+{
+	if (rtas_token_is_open_errinjct(token))
+		return be32_to_cpu(args->rets[1]);
+
+	return nret > 0 ? be32_to_cpu(args->rets[0]) : 0;
+}
+
 /**
  * rtas_call() - Invoke an RTAS firmware function.
  * @token: Identifies the function being invoked.
@@ -1198,6 +1220,16 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 			return -1;
 	}
 
+	/*
+	 * ibm,open-errinjct returns rets[0]=session_token, rets[1]=status.
+	 * We need nret >= 2 to read status from rets[1].  Reject early if
+	 * the caller forgot to account for the extra return cell.
+	 */
+	if (rtas_token_is_open_errinjct(token) && nret < 2) {
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
 	if ((mfmsr() & (MSR_IR|MSR_DR)) != (MSR_IR|MSR_DR)) {
 		WARN_ON_ONCE(1);
 		return -1;
@@ -1213,15 +1245,33 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	va_rtas_call_unlocked(args, token, nargs, nret, list);
 	va_end(list);
 
+	ret = rtas_status_from_args(token, args, nret);
+
 	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args->rets[0]) == -1)
+	 * be completed due to a hardware error.
+	 */
+	if (ret == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
-	if (nret > 1 && outputs != NULL)
-		for (i = 0; i < nret-1; ++i)
-			outputs[i] = be32_to_cpu(args->rets[i + 1]);
-	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	/*
+	 * Copy non-status outputs to the caller's buffer.
+	 *
+	 * For ibm,open-errinjct the layout is:
+	 *   rets[0] = session token  -> outputs[0]
+	 *   rets[1] = status         (returned, not copied)
+	 *
+	 * For all other RTAS functions:
+	 *   rets[0] = status         (returned, not copied)
+	 *   rets[1..nret-1] -> outputs[0..nret-2]
+	 */
+	if (outputs) {
+		if (rtas_token_is_open_errinjct(token)) {
+			outputs[0] = be32_to_cpu(args->rets[0]);
+		} else if (nret > 1) {
+			for (i = 0; i < nret - 1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		}
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
@@ -1896,6 +1946,14 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	if (block_rtas_call(func, nargs, &args))
 		return -EINVAL;
 
+	/*
+	 * ibm,open-errinjct places status at rets[1]; reject calls with
+	 * fewer than 2 return cells before entering RTAS, since reading
+	 * rets[1] for the -1 sentinel would be out of bounds.
+	 */
+	if (rtas_token_is_open_errinjct(token) && nret < 2)
+		return -EINVAL;
+
 	if (token_is_restricted_errinjct(token)) {
 		int err;
 
@@ -1942,9 +2000,11 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	do_enter_rtas(&rtas_args);
 	args = rtas_args;
 
-	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args.rets[0]) == -1)
+	/*
+	 * A -1 return code indicates that the last command couldn't
+	 * be completed due to a hardware error.
+	 */
+	if (rtas_status_from_args(token, &args, nret) == -1)
 		errbuf = __fetch_rtas_last_error(buff_copy);
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
-- 
2.54.0

