Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423671;
	b=eQd14RHqLMkh0GHru6T27XnQ7u67lY5mIgLQdyDjTcH6JfH0k0q7j0LuMCKFsbZYkELf
	 AuLx3C0dQuLNIw2429vLa4TuZHm8Ai0KcZQSnYexMv5K+zie+EySwpm5Nkl1Bp4yrSc7R
	 4Ukt9HsF9fzotfZP9H/weZXa8yjt29+B0beFp7tvRKgm0OOlFYAdHK5EMemVlCZCb4w16
	 TM8MZ8JXuyHihqqGRD+1Am+ZylJpGqR+kAmOsLv8ZZZrkgI/34n+P0T4fXCXG5hLK1NB8
	 U4lqHiz3cUME+jnCbenDli5FexiFBp/O4BgmNGyTStVHr6xrgTF0MP/E9eI0NjY//mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423671;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fk4Xq849+8+EE6qHawhUwxyOI8ZUR4PXXj7Hb0IUYXo=;
	b=Gj5jfOtBnIHHKlzdiUVi3A4FQrXxfsJYZymVqUG1Sezp4f/Ca45LLPpGRc+X4IhEZYNw
	 nuJX95y58nVaI5Fw2s1LpRjldSD1Z+U3lLwT7spih11eAC7z6jPuxvv6inWztzZ3WKn/d
	 jwDZD52Puk1+V4h+GvZah0aW1B9UXVbmtLIIKPtMTASyJ8dFQ3cqlBrtm7JhZSGbI8cTr
	 0/KsoZzOI7arERJKVQ0lva2rVB+B4seoe4+AebIEMFS+Ld6LDS/MjSMFPETeUiUafcB++
	 2NRlgqwh/Z3GPTmDgZYPeBfnn4bYHDL4mTgBlsNxKKH8q/K4RnKWvD/ouZxkgMVWF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="EiV/bj3+";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FA606A31A;
	Mon, 23 Nov 2026 08:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EiV/bj3+
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54mYh2633201;
	Mon, 23 Nov 2026 08:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fk4Xq849+8+EE6qHa
	whUwxyOI8ZUR4PXXj7Hb0IUYXo=; b=EiV/bj3+QNK/tnxVLE6k6rBMepSGh+CKo
	fgQpazuR9xMp8FjQh1qFqNyx2VJbLz4X4N0b1BSkspVom8LK18laRb3W/nNKTjLR
	qomEQdmTWbWH6XLRw9oueKKxoIf4hwHL9ifOm/nzUzPsOKwkPw/0Q+9bKPBBhsf5
	IWLdNgEWMQsUSo5vR4EW40JbwliS5akQJcnWTDuIXcmOJEGqfuHusNUay7x2RBXp
	6a4VUodRDlPRuKLFI/4gO9i/Gj7A8HlH84tDooOHIe7XQXH16Spk0ptpWVNo+u3l
	gasoiEorx+iNZVeTQ+SO154NsJy0wCSMUu/9DePEbrgZfvXOHmDdg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g11yp9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54G3n2817218;
	Mon, 23 Nov 2026 08:47:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjx0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN8lJSb52953470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 08:47:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 721092005A;
	Mon, 23 Nov 2026 08:47:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B62C20040;
	Mon, 23 Nov 2026 08:47:16 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 08:47:16 +0000 (GMT)
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
Subject: [PATCH v7 1/4] powerpc/rtas: Handle ibm,open-errinjct return format
Date: Mon, 23 Nov 2026 14:16:59 +0530
Message-ID: <20261123084658.61330-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
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
X-Proofpoint-ORIG-GUID: gd_tRfcnEETFxSWnH-x911Pf_AXvR28g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX6AbZF55taAlG
 MM2RcPPD02pMdotrmnlL/CWu2P0tDAwUIwGRj7WeAdTNO43hevhkqANR/mFIETtxJnmVh2cp6Vj
 8rCRT5bbn9yrzRNugHaP5iEz+C94q3Q=
X-Proofpoint-GUID: SqRVCCt7Zlp3J4WqzklituqiI-CIl9f9
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b03fd9c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8
 a=W6-AMay0JfweMWvUZhgA:9 a=O8hF6Hzn-FEA:10 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXziVCduh5x0+z
 gZPjE+7axA5QQvSzv2Rq/i0ykPw14pzQwIBrh+252c9mxItBMXIzocnxGohyWgjSM5SsasSkygd
 FvQYFoDeGo05gvG+GwanvaNakoYIY7CsoX5H5zvS9jmocPZUB+9N0uCCqks0JW7zdA0nEzSOzpo
 VooR4E8qYiyQLjF7k5F7YNGhTzraxhmU3k6dkkKA092EsjnYkSKPuTCS8OLsutd77k1OS0eNgQI
 4sKOTNxIuiXoJM5nZR1s71mL+cV+aMCjqUyNpAR0V7Q0kfnO+KF02uVZcLr8r/a32pQXkCxUqE0
 /AjaeIKy50edYuxZU537mX08LJRW0eHOwG+iEogm/Gnf6TnzEOwnE0m11XlOBW2IqPvz8v+7RC2
 yIrbkUbMZupLJTwcjFeZbh74y8vnaNEouUZfQVZ3sPKYDF65J478xSURfXAyPzW+WNIam8b1jxX
 xOZehq63TTN9jD1MGBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034

ibm,open-errinjct returns the session token in rets[0] and the status in
rets[1], unlike other RTAS functions, which return the status in rets[0].
rtas_call() would report the session token as the status and drop the
real status.

Take the status from rets[1] for this function and return the session
token in outputs[0].  This needs exactly two return cells, so reject any
other count from kernel callers with -EINVAL and a one-time warning, and
document the exception in the rtas_call() kernel-doc.

Give the rtas_output tracepoint the index of the status cell, so that it
reports rets[1] as the status and the session token as an additional
output for this function.  A call with no return cells reports status 0
instead of reading a cell that does not exist.

Ensure __fetch_rtas_last_error() and sys_rtas() initialize rtas_args.rets
to point into rtas_args.args[] after copying local arguments, preventing
tracepoint handlers from dereferencing uninitialized memory or reading
stale on-stack values.

sys_rtas() still copies the raw return cells to userspace.  It uses the
status from the right cell for hardware-error (-1) detection and, after
the lockdown check, rejects fewer than two return cells for this function.

Link: https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/trace.h | 26 +++++++---
 arch/powerpc/kernel/rtas.c       | 83 ++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index a7b69b25296b..d731f70aead7 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -146,25 +146,37 @@ TRACE_EVENT(rtas_input,
 	)
 );
 
+/*
+ * @status_idx is the index in rets[] of the status cell: 1 for
+ * ibm,open-errinjct, which returns its session token in rets[0], and 0 for
+ * every other function.  The remaining cells are reported as other outputs.
+ */
 TRACE_EVENT(rtas_output,
 
-	TP_PROTO(struct rtas_args *rtas_args, const char *name),
+	TP_PROTO(struct rtas_args *rtas_args, const char *name,
+		 unsigned int status_idx),
 
-	TP_ARGS(rtas_args, name),
+	TP_ARGS(rtas_args, name, status_idx),
 
 	TP_STRUCT__entry(
 		__field(__u32, nr_other)
 		__field(__s32, status)
 		__string(name, name)
-		__dynamic_array(__u32, other_outputs, be32_to_cpu(rtas_args->nret) - 1)
+		__dynamic_array(__u32, other_outputs,
+				be32_to_cpu(rtas_args->nret) ?
+				be32_to_cpu(rtas_args->nret) - 1 : 0)
 	),
 
 	TP_fast_assign(
-		__entry->nr_other = be32_to_cpu(rtas_args->nret) - 1;
-		__entry->status = be32_to_cpu(rtas_args->rets[0]);
+		u32 nret = be32_to_cpu(rtas_args->nret);
+		u32 *other = __get_dynamic_array(other_outputs);
+		u32 i;
+
+		__entry->nr_other = nret ? nret - 1 : 0;
+		__entry->status = nret ? be32_to_cpu(rtas_args->rets[status_idx]) : 0;
 		__assign_str(name);
-		be32_to_cpu_array(__get_dynamic_array(other_outputs),
-				  &rtas_args->rets[1], __entry->nr_other);
+		for (i = 0; i < __entry->nr_other; i++)
+			other[i] = be32_to_cpu(rtas_args->rets[i < status_idx ? i : i + 1]);
 	),
 
 	TP_printk("%s status: %d, other outputs: %s", __get_str(name), __entry->status,
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..201be33d9bd3 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -693,6 +693,32 @@ static const struct rtas_function *rtas_token_to_function(s32 token)
 /* This is here deliberately so it's only used in this file */
 void enter_rtas(unsigned long);
 
+static inline bool rtas_token_is_open_errinjct(s32 token)
+{
+	return token == rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+}
+
+/*
+ * Return the index of the status cell in rets[].  ibm,open-errinjct returns
+ * the session token in rets[0] and the status in rets[1].  Every other RTAS
+ * function returns the status in rets[0].
+ */
+static unsigned int rtas_status_idx(s32 token, u32 nret)
+{
+	return (nret >= 2 && rtas_token_is_open_errinjct(token)) ? 1 : 0;
+}
+
+/* Return the status of a completed call, or 0 if it has no return cells. */
+static int rtas_status_from_args(s32 token, struct rtas_args *args)
+{
+	u32 nret = be32_to_cpu(args->nret);
+
+	if (!nret)
+		return 0;
+
+	return be32_to_cpu(args->rets[rtas_status_idx(token, nret)]);
+}
+
 static void __do_enter_rtas(struct rtas_args *args)
 {
 	enter_rtas(__pa(args));
@@ -719,7 +745,9 @@ static void __do_enter_rtas_trace(struct rtas_args *args)
 	__do_enter_rtas(args);
 
 	trace_rtas_ll_exit(args);
-	trace_rtas_output(args, func->name);
+	trace_rtas_output(args, func->name,
+			  rtas_status_idx(be32_to_cpu(args->token),
+					  be32_to_cpu(args->nret)));
 }
 
 static void do_enter_rtas(struct rtas_args *args)
@@ -1034,6 +1062,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 
 	save_args = rtas_args;
 	rtas_args = err_args;
+	rtas_args.rets = &rtas_args.args[2];
 
 	do_enter_rtas(&rtas_args);
 
@@ -1122,20 +1151,28 @@ static bool token_is_restricted_errinjct(s32 token)
  * @token: Identifies the function being invoked.
  * @nargs: Number of input parameters. Does not include token.
  * @nret: Number of output parameters, including the call status.
- * @outputs: Array of @nret output words.
+ * @outputs: Array of @nret - 1 output words, or NULL.
  * @....: List of @nargs input parameters.
  *
  * Invokes the RTAS function indicated by @token, which the caller
  * should obtain via rtas_function_token().
  *
  * The @nargs and @nret arguments must match the number of input and
- * output parameters specified for the RTAS function.
+ * output parameters specified for the RTAS function.  @nret includes the
+ * status cell, so @outputs normally receives the remaining @nret - 1
+ * return cells.
  *
- * rtas_call() returns RTAS status codes, not conventional Linux errno
- * values. Callers must translate any failure to an appropriate errno
- * in syscall context. Most callers of RTAS functions that can return
- * -2 or 990x should use rtas_busy_delay() to correctly handle those
- * statuses before calling again.
+ * ibm,open-errinjct is the exception: it returns its status in rets[1]
+ * and a session token in rets[0].  rtas_call() still returns the status,
+ * and @outputs[0] receives the session token.  @nret must be 2 for this
+ * function; any other value fails with -EINVAL, a Linux errno rather
+ * than an RTAS status, without calling RTAS.
+ *
+ * Apart from that case, rtas_call() returns RTAS status codes, not
+ * conventional Linux errno values. Callers must translate any failure to
+ * an appropriate errno in syscall context. Most callers of RTAS functions
+ * that can return -2 or 990x should use rtas_busy_delay() to correctly
+ * handle those statuses before calling again.
  *
  * The return value descriptions are adapted from 7.2.8 [RTAS] Return
  * Codes of the PAPR and CHRP specifications.
@@ -1198,6 +1235,12 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 			return -1;
 	}
 
+	if (rtas_token_is_open_errinjct(token) && nret != 2) {
+		WARN_ONCE(1, "rtas: ibm,open-errinjct requires exactly two return cells (got %d)\n",
+			  nret);
+		return -EINVAL;
+	}
+
 	if ((mfmsr() & (MSR_IR|MSR_DR)) != (MSR_IR|MSR_DR)) {
 		WARN_ON_ONCE(1);
 		return -1;
@@ -1215,13 +1258,20 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
-	if (be32_to_cpu(args->rets[0]) == -1)
+	if (rtas_status_from_args(token, args) == -1)
 		buff_copy = __fetch_rtas_last_error(NULL);
 
-	if (nret > 1 && outputs != NULL)
-		for (i = 0; i < nret-1; ++i)
-			outputs[i] = be32_to_cpu(args->rets[i + 1]);
-	ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	if (rtas_token_is_open_errinjct(token)) {
+		/* nret is 2: rets[0] is the session token, rets[1] the status. */
+		if (outputs)
+			outputs[0] = be32_to_cpu(args->rets[0]);
+		ret = be32_to_cpu(args->rets[1]);
+	} else {
+		if (nret > 1 && outputs != NULL)
+			for (i = 0; i < nret-1; ++i)
+				outputs[i] = be32_to_cpu(args->rets[i + 1]);
+		ret = (nret > 0) ? be32_to_cpu(args->rets[0]) : 0;
+	}
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
 	raw_spin_unlock_irqrestore(&rtas_lock, flags);
@@ -1904,6 +1954,10 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 			return err;
 	}
 
+	/* ibm,open-errinjct needs rets[1] for its status. */
+	if (rtas_token_is_open_errinjct(token) && nret < 2)
+		return -EINVAL;
+
 	/* Need to handle ibm,suspend_me call specially */
 	if (token == rtas_function_token(RTAS_FN_IBM_SUSPEND_ME)) {
 
@@ -1939,12 +1993,13 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	cookie = lockdep_pin_lock(&rtas_lock);
 
 	rtas_args = args;
+	rtas_args.rets = &rtas_args.args[nargs];
 	do_enter_rtas(&rtas_args);
 	args = rtas_args;
 
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
-	if (be32_to_cpu(args.rets[0]) == -1)
+	if (rtas_status_from_args(token, &args) == -1)
 		errbuf = __fetch_rtas_last_error(buff_copy);
 
 	lockdep_unpin_lock(&rtas_lock, cookie);
-- 
2.54.0

